
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_care/src/models/user.dart';
import 'package:my_care/src/models/user_fields.dart';
import 'package:my_care/src/services/user_db_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class UserRepository with ChangeNotifier{
  final FirebaseAuth _auth;
  User? _user;
  Status _status = Status.uninitialized;
  String _error = '';
  String _userDisplayName = '';
  StreamSubscription? _userListener;
  UserModel? _fsUser;
  bool _loading = false;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _error = '';
    _loading = true;
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }


  String get error => _error;
  Status get status => _status;
  User? get fbUser => _user;
  UserModel? get user => _fsUser;
  bool get isLoading => _loading;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _error = '';
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message!;
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }



  Future<bool> signup(String email, String password, String fullName) async {
    try {
      _status = Status.authenticating;
      _userDisplayName = fullName;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _error = '';
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message!;
      _status = Status.unauthenticated;
      notifyListeners();
      return false;
    }
  }


  Future signOut() async {
    _auth.signOut();
    _status = Status.unauthenticated;
    _fsUser = null;
    _userListener?.cancel();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
      _fsUser = null;
      _user = null;
    } else {
      _user = firebaseUser;
      _saveUserRecord();
      _userListener = userDBS.streamSingle(_user!.uid).listen((user) {
        _fsUser = user;
        _loading = false;
        notifyListeners();
      });
      _status = Status.authenticated;
    }
    notifyListeners();
  }


  Future<void> _saveUserRecord() async {
    if (_user == null) return;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    UserModel user = UserModel(
      email: _user!.email!,
      name: _user!.displayName ?? _userDisplayName,
      photoUrl: _user!.photoURL,
      id: _user?.uid,
      registrationDate: DateTime.now().toUtc(),
      lastLoggedIn: DateTime.now().toUtc(),
      introSeen: false,
    );

    UserModel? existing = await userDBS.getSingle(_user!.uid);
    if (existing == null) {
      await userDBS.create(user.toMap(), id: _user!.uid);
      _fsUser = user;
    } else {
      await userDBS.updateData(_user!.uid, {
        UserFields.lastLoggedIn: FieldValue.serverTimestamp(),
        UserFields.buildNumber: buildNumber,
      });
    }
  }




  @override
  void dispose() {
    _userListener?.cancel();
    super.dispose();
  }





}
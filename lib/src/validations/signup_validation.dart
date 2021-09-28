import 'package:flutter/foundation.dart';
import 'package:my_care/src/utils/app_extensions.dart';

import 'validation_item.dart';

class SignUpValidation extends ChangeNotifier{


  ValidationItem _fullName = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _vPassword = ValidationItem(null, null);



  //Getters
  ValidationItem get fullName => _fullName;
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  ValidationItem get vPassword => _vPassword;
  bool get isValid {
    if(_fullName.value != null && _email.value !=null && _password.value != null && _vPassword.value != null){
      return true;
    }
    return false;

  }


  //Setters
  void fullNameDelta(String value){
    if(value.length >= 3){
      _fullName = ValidationItem(value, null);
    } else{
      _fullName = ValidationItem(null, 'Full name must be 3 characters or more.');
    }
    notifyListeners();
  }

  void emailDelta(String value){
    if(value.isValidEmail()){
      _email = ValidationItem(value, null);
    } else{
      _email = ValidationItem(null, 'Provide a valid email');
    }
    notifyListeners();
  }

  void passwordDelta(String value){
    if(value.length >=6 ){
      _password = ValidationItem(value, null);
    } else {
      _password = ValidationItem(null, 'Password must be 6 characters or more');
    }
    notifyListeners();
  }

  void vPasswordDelta(String value){
    if(_password.value == value){
      _vPassword = ValidationItem(value, null);
    } else{
      _vPassword = ValidationItem(null, 'Passwords must match');
    }
    notifyListeners();
  }

}
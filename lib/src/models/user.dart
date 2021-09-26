import 'user_fields.dart';

class UserModel {
  String id;
  String name;
  String email;
  DateTime? lastLoggedIn;
  DateTime? registrationDate;
  String? photoUrl;
  int? buildNumber;
  bool? introSeen;

  UserModel(
      {required this.id,
        required this.name,
        required this.email,
        this.lastLoggedIn,
        this.registrationDate,
        this.photoUrl,
        this.introSeen,
        this.buildNumber});

  UserModel.fromDS(this.id, Map<String, dynamic> data):
        name = data[UserFields.name],
        email = data[UserFields.email],
        lastLoggedIn = data[UserFields.lastLoggedIn]?.toDate(),
        registrationDate = data[UserFields.registrationDate]?.toDate(),
        photoUrl = data[UserFields.photoUrl],
        buildNumber=data[UserFields.buildNumber],
        introSeen=data[UserFields.introSeen];


  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[UserFields.id] = id;
    data[UserFields.name] = name;
    data[UserFields.email] = email;
    data[UserFields.lastLoggedIn] = lastLoggedIn;
    data[UserFields.registrationDate] = registrationDate;
    data[UserFields.photoUrl] = photoUrl;
    data[UserFields.buildNumber] = buildNumber;
    data[UserFields.introSeen] = introSeen;
    return data;
  }
}
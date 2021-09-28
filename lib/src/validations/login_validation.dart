
import 'package:flutter/foundation.dart';
import 'package:my_care/src/utils/app_extensions.dart';
import 'package:my_care/src/validations/validation_item.dart';

class LoginValidation extends ChangeNotifier{

  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

  ValidationItem get email => _email;
  ValidationItem get password => _password;
  bool get canLogin{
    if(_email.value != null && _password.value != null){
      return true;
    }
    return false;
  }

  /// Setters
  void emailDelta(String value){
    if(value.isValidEmail()){
      _email = ValidationItem(value, null);
    } else{
      _email = ValidationItem(null, 'Please provide a valid email.');
    }
    notifyListeners();
  }

  void passwordDelta(String value){
    if(value.length >= 6){
      _password = ValidationItem(value, null);
    } else{
      _password = ValidationItem(null, 'Password must be more than 5 characters.');
    }
    notifyListeners();
  }


}
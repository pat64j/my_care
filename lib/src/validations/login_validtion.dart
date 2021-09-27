
import 'package:flutter/foundation.dart';
import 'package:my_care/src/utils/app_extensions.dart';
import 'package:my_care/src/validations/validation_item.dart';

class LoginValidation extends ChangeNotifier{

  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

  ValidationItem get email => _password;
  ValidationItem get password => _password;

  bool get canLogin{
    if(_email.value != null && _password.value != null){
      return true;
    }
    return false;
  }

  void emailDelta(String email){
    if(email.isValidEmail()){
      _email = ValidationItem(email, null);
    } else{
      _email = ValidationItem(null, 'Please provide a valid email.');
    }
  }

  void passwordDelta(String password){
    if(password.length >= 6){
      _password = ValidationItem(password, null);
    } else{
      _email = ValidationItem(null, 'Password must be more than 5 characters.');
    }
  }


}
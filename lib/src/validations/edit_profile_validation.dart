import 'package:flutter/foundation.dart';
import 'package:my_care/src/utils/app_extensions.dart';
import 'package:intl/intl.dart';

import 'validation_item.dart';

class EditProfileValidation extends ChangeNotifier{
  ValidationItem _fullName = ValidationItem(null, null);
  ValidationItem _phoneNumber = ValidationItem(null, null);
  ValidationItem _address = ValidationItem(null, null);
  ValidationItem _dateOfBirth = ValidationItem(null, null);
  ValidationItem _gender = ValidationItem(null, null);
  ValidationItem _primaryLanguage = ValidationItem(null, null);

  ///Getters
  ValidationItem get fullName => _fullName;
  ValidationItem get phoneNumber => _phoneNumber;
  ValidationItem get address => _address;
  ValidationItem get dateOfBirth => _dateOfBirth;
  ValidationItem get gender => _gender;
  ValidationItem get primaryLanguage => _primaryLanguage;
  bool get isValid {

    if(_fullName.value !=null &&
      _phoneNumber.value != null &&
      _address.value != null &&
      _dateOfBirth.value != null &&
      gender.value != null
    ) return true;

    return false;
  }


  ///Setters
  void fullNameDelta(String value){
    if(value.length >=3){
      _fullName = ValidationItem(value, null);
    } else {
      _fullName = ValidationItem(null, 'Full Name must be 3 characters or more');
    }
    notifyListeners();
  }

  void phoneNumberDelta(String value){
    if(value.isValidPhoneNumber()){
      _phoneNumber = ValidationItem(value, null);
    } else {
      _phoneNumber = ValidationItem(null, 'Please enter a valid phone number');
    }
    notifyListeners();
  }

  void addressDelta(String value){
    if(value.isNotEmpty){
      _address = ValidationItem(value, null);
    } else {
      _address = ValidationItem(null, 'Address is required');
    }
    notifyListeners();
  }

  void dateOfBirthDelta(String value){
    try{
      if(value.isEmpty){
        _dateOfBirth = ValidationItem(null, 'Date of birth is required.');
      } else{
        final DateTime selectedDate = DateFormat('dd-MMM-yyy').parse(value);
        final int diff = DateTime.now().year - selectedDate.year;
        if(diff >= 18){
          _dateOfBirth = ValidationItem(value, null);
        } else{
          _dateOfBirth = ValidationItem(null, 'You must be 18 years or above.');
        }

      }
      notifyListeners();
    } catch(error){
      print(error);
      _dateOfBirth = ValidationItem(null, 'Invalid format');
      notifyListeners();
    }
  }

  void genderDelta(String value){
    if(value.isNotEmpty){
      _gender = ValidationItem(value, null);
    } else {
      _gender = ValidationItem(null, 'Gender is required.');
    }
    notifyListeners();
  }

  void primaryLanguageDelta(String value){
    String val = value.isNotEmpty ? value : '';
    _primaryLanguage = ValidationItem(val, null);
    notifyListeners();
  }




}
extension EmailValidator on String {
  bool isValidEmail() {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(pattern).hasMatch(this);
  }

  bool isValidPhoneNumber() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    return RegExp(pattern).hasMatch(this);
  }

}

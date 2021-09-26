import 'package:flutter/material.dart';

class AppRoutes {
  static const home = "/";
  static const splash = "splash";
  static const login = "login";
  static const signup = "signup";
  static const userInfo = "user_info";
  static const String profile = "profile";
  static const String editProfile = "edit_profile";


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case home:
            return AuthHomePage();
          case userInfo:
            return UserInfoPage();
          case editProfile:
            return EditProfile(
              user: settings.arguments,
            );
          case profile:
            return UserProfile();
          case splash:
          default:
            return Splash();
        }
      });
  }
}

import 'package:flutter/material.dart';

import 'views/auth/auth_home.dart';
import 'views/auth/splash.dart';
import 'views/user/edit_profile.dart';
import 'views/user/user_info.dart';
import 'views/user/user_profile.dart';

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
            return const AuthHomePage();
          case userInfo:
            return const UserInfoPage();
          case editProfile:
            return EditProfile(
              user: settings.arguments,
            );
          case profile:
            return const UserProfile();
          case splash:
          default:
            return const Splash();
        }
      });
  }
}

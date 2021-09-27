import 'package:flutter/material.dart';

import 'views/auth/auth_home.dart';
import 'views/auth/auth_reset_password.dart';
import 'views/auth/auth_sign_up.dart';
import 'views/auth/splash.dart';
import 'views/home/home_dash.dart';
import 'views/user/edit_profile.dart';
import 'views/user/user_info.dart';
import 'views/user/user_profile.dart';

class AppRoutes {
  static const home = "/";
  static const splash = "splash";
  static const login = "login";
  static const signup = "signup";
  static const userInfo = "user_info";
  static const homeDash = "home_dash";
  static const forgotPassword = "forgot_password";
  static const String profile = "profile";
  static const String editProfile = "edit_profile";


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case login:
            return const AuthHomePage();
          case signup:
            return const SignUpView();
          case forgotPassword:
            return const ResetPasswordView();
          case home:
            return const DashboardPage();
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

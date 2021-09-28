import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_care/src/providers/providers.dart';
import 'package:my_care/src/repos/user_repo.dart';
import 'package:my_care/src/views/home/home_dash.dart';

import 'auth_login.dart';

class AuthHomePage extends HookConsumerWidget {
  const AuthHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = ref.watch(userRepoProvider);
    switch (userRepo.status){
      case Status.unauthenticated:
        return const LoginView();
      case Status.authenticating:
      case Status.authenticated:
        return const DashboardPage();
      case Status.uninitialized:
      default:
      return const LoginView();
    }
  }
}

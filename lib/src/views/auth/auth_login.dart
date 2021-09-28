import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_care/src/providers/providers.dart';
import 'package:my_care/src/repos/user_repo.dart';
import 'package:my_care/src/values/all_resources.dart';

import '../../app_routes.dart';

/// Displays the login view
class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginService = ref.watch(loginValidationProvider);
    final userRepo = ref.watch(userRepoProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 80),
                  child: Image.asset(R.imgs.logo),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (String val) {
                          loginService.emailDelta(val);
                        },
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                          labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                          errorText: loginService.email.error,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (String val) {
                          loginService.passwordDelta(val);
                        },
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                          labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                          errorText: loginService.password.error,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: (){
                              Navigator.restorablePushNamed(context, AppRoutes.signup);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.createAccount,
                              style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                          ),
                          const Text('|'),
                          TextButton(
                            onPressed: (){
                              Navigator.restorablePushNamed(context, AppRoutes.forgotPassword);
                            },
                            child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: !loginService.canLogin || userRepo.status == Status.authenticating ? null:() async {
                            bool isSignedIn = await userRepo.signIn(
                                loginService.email.value!,
                                loginService.password.value!
                            );
                            if(isSignedIn){
                              Navigator.restorablePushNamedAndRemoveUntil(context, AppRoutes.homeDash, (route) => false);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (userRepo.status == Status.authenticating) const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ) else const SizedBox(height: 0, width: 0,),
                                Text(
                                  AppLocalizations.of(context)!.signIn.toUpperCase(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

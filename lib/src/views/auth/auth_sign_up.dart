import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_care/src/providers/providers.dart';
import 'package:my_care/src/repos/user_repo.dart';
import 'package:my_care/src/values/all_resources.dart';

import '../../app_routes.dart';

/// Displays the login view
class SignUpView extends HookConsumerWidget {
  const SignUpView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validationService = ref.watch(signUpValidationProvider);
    final userRepo = ref.watch(userRepoProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
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
                        validationService.fullNameDelta(val);
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.fullName,
                        labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                        errorText: validationService.fullName.error,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      onChanged: (String val) {
                        validationService.emailDelta(val);
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                        labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                        errorText: validationService.email.error,
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
                        validationService.passwordDelta(val);
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                        errorText: validationService.password.error,
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
                    TextField(
                      onChanged: (String val) {
                        validationService.vPasswordDelta(val);
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.verifyPassword,
                        labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                        errorText: validationService.vPassword.error,
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
                          onPressed: () {
                            Navigator.restorablePushNamed(context, AppRoutes.login);
                          },
                          child: Text(AppLocalizations.of(context)!.signIn,
                              style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                        ),
                        const Text('|'),
                        TextButton(
                          onPressed: () {
                            Navigator.restorablePushNamed(context, AppRoutes.forgotPassword);
                          },
                          child: Text(AppLocalizations.of(context)!.forgotPassword,
                              style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: validationService.isValid
                            ? ()async {
                                bool isSignedIn = await userRepo.signup(
                                    validationService.email.value!,
                                    validationService.password.value!,
                                    validationService.fullName.value!
                                );
                                if (isSignedIn){
                                  Navigator.restorablePushNamedAndRemoveUntil(context, AppRoutes.homeDash, (route) => false);
                                }
                              }
                            : null,
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
                                AppLocalizations.of(context)!.signUp.toUpperCase(),
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
    );
  }
}

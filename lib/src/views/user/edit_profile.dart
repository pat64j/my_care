import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_care/src/providers/providers.dart';
import 'package:my_care/src/repos/user_repo.dart';
import 'package:intl/intl.dart';


import '../../app_routes.dart';
import 'profile_widget.dart';


class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({Key? key, Object? user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late TextEditingController _dateinput;

  @override
  void initState() {
    super.initState();
    _dateinput = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final validationService = ref.watch(editProfileValidationProvider);
    final userRepo = ref.watch(userRepoProvider);

    return Scaffold(
      body: SafeArea(
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
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children:  [
                  ProfileWidget(
                    imagePath: 'https://robohash.org/b02eeef78cafa55e29ab78b6f264a8ed?set=set4&bgset=&size=400x400',
                    onClick: (){
                      Navigator.restorablePushNamed(context, AppRoutes.editProfile);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(userRepo.fbUser?.email ?? '',
                        style: const TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (String val) {
                            validationService.fullNameDelta(val);
                          },
                          controller: TextEditingController()..text = userRepo.user!.name!,
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
                        const SizedBox(height: 15,),
                        TextField(
                          onChanged: (String val) {
                            validationService.phoneNumberDelta(val);
                          },
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.phone,
                            labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                            errorText: validationService.phoneNumber.error,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 15,),
                        TextField(
                          onChanged: (String val) {
                            validationService.addressDelta(val);
                          },
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.address,
                            labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                            errorText: validationService.address.error,
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
                        const SizedBox(height: 15,),
                        TextField(
                          controller: _dateinput,
                          onTap: () async{
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(1870), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );
                            if(pickedDate != null ){
                              String formattedDate = DateFormat('dd-MMM-yyyy').format(pickedDate);

                              validationService.dateOfBirthDelta(formattedDate.toString());

                              setState(() {
                                _dateinput.text = formattedDate.toString(); //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.dateOfBirth,
                            labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                            errorText: validationService.dateOfBirth.error,
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
                        const SizedBox(height: 15,),
                        TextField(
                          onChanged: (String val) {
                            // validationService.fullNameDelta(val);
                          },
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.gender,
                            labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                            // errorText: validationService.fullName.error,
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
                        const SizedBox(height: 15,),
                        TextField(
                          onChanged: (String val) {
                            // validationService.fullNameDelta(val);
                          },
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.primaryLanguage,
                            labelStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                            // errorText: validationService.fullName.error,
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
                        const SizedBox(height: 15,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){},
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
                                    AppLocalizations.of(context)!.save.toUpperCase(),
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
            )

          ],
        ),
      ),
    );
  }
}

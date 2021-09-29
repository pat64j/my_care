import 'package:flutter/material.dart';

import '../../app_routes.dart';
import 'profile_widget.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: const [
                      Text("Patrick Adonteng",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
                      Text("pat64j@gmail.com",
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      )
                    ],
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_care/src/providers/providers.dart';

import '../../app_routes.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = ref.watch(userRepoProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: Container(color: Colors.deepPurple),
                flex: 2,
              ),
              Expanded(
                child: Container(color: Colors.transparent),
                flex: 5,
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                 ListTile(
                    contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    leading: const CircleAvatar(),
                    title: const Text(
                      'Dashboard',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      '10 items',
                      style: TextStyle(color: Colors.blue),
                    ),
                    trailing: !userRepo.isLoading ?
                    Column(
                      children: [
                        CircleAvatar(
                          child: IconButton(
                              onPressed: (){
                                userRepo.signOut().then((_){
                                  Navigator.restorablePushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                                });
                              },
                              icon: const Icon(Icons.logout,color: Colors.white,)
                          ),
                        ),
                        const Text('Logout',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white
                        ),)
                      ],
                    ):
                    const CircleAvatar(
                      child: SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      ),
                    )



                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: GridView.count(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: 2,
                      childAspectRatio: .90,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.notifications_active,
                                  size: 100,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 20,),
                                const Text(
                                  'Notifications',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 100,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 20,),
                                const Text(
                                  'Schedule',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.payment,
                                  size: 100,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 20,),
                                const Text(
                                  'Payments',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.auto_graph,
                                  size: 100,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 20,),
                                const Text(
                                  'Report',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.account_circle_sharp,
                                  size: 100,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(height: 20,),
                                const Text(
                                  'My Profile',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

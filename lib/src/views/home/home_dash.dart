import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [dashBg, content],
      ),
    );
  }

  get dashBg => Column(
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
      );

  get content => SafeArea(
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => const ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '10 items',
          style: TextStyle(color: Colors.blue),
        ),
        trailing: CircleAvatar(),
      );

  get grid => Expanded(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: GridView.count(
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            childAspectRatio: .90,
            children: List.generate(6, (_) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [FlutterLogo(), Text('data')],
                  ),
                ),
              );
            }),
          ),
        ),
      );
}

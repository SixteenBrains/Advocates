import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home';
  const Home({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const Home(),
    );
  }

  @override
  Widget build(BuildContext context) {
    //FirebaseAuth.instance.signOut();
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

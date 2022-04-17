import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2ED573),
      body: Center(
        child: (
            //SvgPicture.asset(
            Image.asset(
          'assets/images/image_big.png',
          width: 120.0,
          height: 120.0,
          //  color: ,
        )),
      ),
    );
  }
}

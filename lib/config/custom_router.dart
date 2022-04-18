import 'package:advocates/screens/account/update_account.dart';

import '/screens/nav/nav_screen.dart';
import '/screens/account/account_screen.dart';
import '/screens/home/home.dart';
import '/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import '/screens/splash/splash_screen.dart';

import 'auth_wrapper.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case SplashScreen.routeName:
        return SplashScreen.route();

      case Home.routeName:
        return Home.route();

      case SignUpScreen.routeName:
        return SignUpScreen.route();

      case AccountScreen.routeName:
        return AccountScreen.route();

      case NavScreen.routeName:
        return NavScreen.route();

      case UpdateAccount.routeName:
        return UpdateAccount.route();

      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRouter(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

import '/screens/update-account/update_account_screen.dart';
import '/screens/set/add_subset.dart';
import '/screens/account/screens/account_screen.dart';
import '/screens/settings/screens/legal_settings.dart';
import '/screens/settings/screens/notification_settings.dart';
import '/screens/account/screens/formate_screen.dart';
import '/screens/settings/settings_screen.dart';
import '/screens/account/screens/cause_screen.dart';
import '/screens/nav/nav_screen.dart';
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

      case SignUpScreen.routeName:
        return SignUpScreen.route();

      case AccountScreen.routeName:
        return AccountScreen.route();

      case NavScreen.routeName:
        return NavScreen.route();

      case UpdateAccount.routeName:
        return UpdateAccount.route();

      case CauseScreen.routeName:
        return CauseScreen.route();

      case FormateScreen.routeName:
        return FormateScreen.route();

      case SettingsScreen.routeName:
        return SettingsScreen.route();

      case LegalSettings.routeName:
        return LegalSettings.route();

      case NotificationsSettings.routeName:
        return NotificationsSettings.route();

      case AddSubset.routeName:
        return AddSubset.route();

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

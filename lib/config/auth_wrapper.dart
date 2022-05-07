import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '/screens/nav/nav_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/signup/signup_screen.dart';

class AuthWrapperArgs {
  final PendingDynamicLinkData? initialLink;

  const AuthWrapperArgs({required this.initialLink});
}

class AuthWrapper extends StatelessWidget {
  final PendingDynamicLinkData? initialLink;
  static const String routeName = '/authwrapper';

  const AuthWrapper({Key? key, required this.initialLink}) : super(key: key);

  static Route route({required AuthWrapperArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AuthWrapper(initialLink: args.initialLink),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Initial link from args $initialLink');
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(SignUpScreen.routeName);
        } else {
          // Navigator.of(context).pushNamed(Home.routeName);
          //Navigator.of(context).pushNamed(AccountScreen.routeName);
          Navigator.of(context).pushNamed(NavScreen.routeName,
              arguments: NavScreenArgs(initialLink: initialLink));
        }
      },
      child: const Scaffold(
        body: LoadingIndicator(),
      ),
    );
  }
}

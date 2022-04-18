import '/screens/nav/nav_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/signup/signup_screen.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/authwrapper';

  const AuthWrapper({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(SignUpScreen.routeName);
        } else {
          // Navigator.of(context).pushNamed(Home.routeName);
          //Navigator.of(context).pushNamed(AccountScreen.routeName);
          Navigator.of(context).pushNamed(NavScreen.routeName);
        }
      },
      child: const Scaffold(
        body: LoadingIndicator(),
      ),
    );
  }
}

import '/enums/enums.dart';
import '/screens/account/account_screen.dart';
import 'package:flutter/material.dart';

class SwitchScreen extends StatelessWidget {
  final NavItem navItem;

  const SwitchScreen({Key? key, required this.navItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (navItem) {
      case NavItem.dashboard:
        return const AccountScreen();

      case NavItem.wallet:
        return Container();

      case NavItem.mic:
        return Container();

      case NavItem.invite:
        return Container();

      default:
        return const Center(
          child: Text('Wrong'),
        );
    }
  }
}

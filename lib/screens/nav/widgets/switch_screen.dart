import '/screens/menu-sets/menu_sets_screen.dart';
import '/screens/wallet/wallet_screen.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/invite/invite_screen.dart';
import '/enums/enums.dart';
import '../../account/screens/account_screen.dart';
import 'package:flutter/material.dart';

class SwitchScreen extends StatelessWidget {
  final NavItem navItem;

  const SwitchScreen({Key? key, required this.navItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (navItem) {
      case NavItem.account:
        return const AccountScreen();

      case NavItem.wallet:
        return const WalletScreen();

      case NavItem.dashboard:
        return const DashBoard();

      case NavItem.sets:
        return const MenuSetsScreen();

      case NavItem.invite:
        return const InviteScreen();

      default:
        return const Center(
          child: Text('Wrong'),
        );
    }
  }
}

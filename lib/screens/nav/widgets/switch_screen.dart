import '/blocs/auth/auth_bloc.dart';
import '/screens/dashboard/bloc/dashboard_bloc.dart';
import '/repositories/set/set_repository.dart';
import '/screens/set/cubit/set_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/account/screens/account_screen.dart';
import '/screens/set/set_manager.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/invite/invite_screen.dart';
import '/enums/enums.dart';
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
        return const InviteScreen();

      case NavItem.dashboard:
        return BlocProvider(
          create: (context) => DashboardBloc(
            authBloc: context.read<AuthBloc>(),
            setRepository: context.read<SetRepository>(),
          )..add(LoadSubSets()),
          child: const DashBoard(),
        );

      case NavItem.sets:
        return BlocProvider<SetCubit>(
          create: (context) => SetCubit(
              setRepository: context.read<SetRepository>(),
              authBloc: context.read<AuthBloc>()),
          child: const SetManager(),
        );

      case NavItem.invite:
        return const InviteScreen();

      default:
        return const Center(
          child: Text('Wrong'),
        );
    }
  }
}

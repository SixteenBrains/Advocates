import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/nav_bloc.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/switch_screen.dart';

class NavScreen extends StatefulWidget {
  static const String routeName = '/nav';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<NavBloc>(
        create: (context) => NavBloc(),
        child: const NavScreen(),
      ),
    );
  }

  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          return Scaffold(
            // backgroundColor: Colors.black45,
            //  backgroundColor: Color.fromRGBO(25, 23, 37, 1),
            body: SwitchScreen(navItem: state.item),
            bottomNavigationBar: BottomNavBar(
              navItem: state.item,
              isListening: state.isListening,
              onitemSelected: (item) => BlocProvider.of<NavBloc>(context)
                  .add(UpdateNavItem(item: item)),
            ),
          );
        },
      ),
    );
  }
}

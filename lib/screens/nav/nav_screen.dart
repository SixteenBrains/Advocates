import '/blocs/auth/auth_bloc.dart';
import '/config/paths.dart';
import '/widgets/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/nav_bloc.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/switch_screen.dart';

class NavScreenArgs {
  final PendingDynamicLinkData? initialLink;

  const NavScreenArgs({required this.initialLink});
}

class NavScreen extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  static const String routeName = '/nav';

  const NavScreen({Key? key, required this.initialLink}) : super(key: key);

  static Route route({required NavScreenArgs args}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<NavBloc>(
        create: (context) => NavBloc(),
        child: NavScreen(initialLink: args.initialLink),
      ),
    );
  }

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  void initState() {
    super.initState();
    getInitialLink();
    addPromotedBy();
  }

  void addPromotedBy() async {
    try {
      if (widget.initialLink != null) {
        ShowSnackBar.showSnackBar(context,
            title: 'Initial Link received ${widget.initialLink?.link}');
      }
    } catch (error) {
      print('Error in adding promoted by ${error.toString()}');
      ShowSnackBar.showSnackBar(context,
          title: 'Error in adding promoted by ${error.toString()}');
    }
  }

  void getInitialLink() async {
    try {
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        final link = dynamicLinkData.link;
        final promoterId = link.queryParameters['id'];
        final currentUserId = context.read<AuthBloc>().state.user?.uid;
        final _firestore = FirebaseFirestore.instance;

        // Todo: we will add only this data when
        //the user is new or just created his account
        await _firestore
            .collection(Paths.users)
            .doc(promoterId)
            .collection(Paths.promotedTo)
            .doc(currentUserId)
            .set({});

        await _firestore
            .collection(Paths.users)
            .doc(currentUserId)
            .collection(Paths.promotedBy)
            .doc(promoterId)
            .set({});
      }).onError((error) {
        // Handle errors
      });
    } catch (error) {
      print('Error in getting initial link ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Initial link received in nav screen ${widget.initialLink}');
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

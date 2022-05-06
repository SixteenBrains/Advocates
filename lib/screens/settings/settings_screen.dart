import 'package:advocates/constants/constants.dart';

import '/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/widgets/options_button.dart';

import '/screens/settings/screens/legal_settings.dart';
import '/screens/settings/screens/notification_settings.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SettingsScreen(),
    );
  }

  Future<void> _showMyDialog(
    BuildContext context, {
    required String label,
    required VoidCallback onConfirm,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/modal_warning.png',
                height: 64.0,
                width: 64.0,
              ),
              const SizedBox(height: 10.0),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'This action cannot be reversed, are you sure you want to do this?',
                style: TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 45.0,
                width: 200.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colorBrighest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onPressed: () {
                    onConfirm();
                    // context.read<AuthBloc>().add(DeleteAccount());
                    Navigator.of(context).pop();
                    // context
                    //     .read<NavBloc>()
                    //     .add(const UpdateNavItem(item: NavItem.account));
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     NavScreen.routeName, (route) => false);
                  },
                  child: const Text(
                    'CONFIRM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          'SETTINGS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50.0),
                Center(
                  child: Image.asset(
                    'assets/images/settings.png',
                    height: 64.0,
                    width: 64.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'SETTINGS',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Configure how you use Setment and decide\nwhat types of notifications you\'d like to receive.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                OptionButtons(
                  label: 'LEGAL',
                  onTap: () =>
                      Navigator.of(context).pushNamed(LegalSettings.routeName),
                ),
                OptionButtons(
                  label: 'NOTIFICATIONS',
                  onTap: () => Navigator.of(context)
                      .pushNamed(NotificationsSettings.routeName),
                ),
                const SizedBox(height: 15.0),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.grey.shade600,
                  ),
                  onPressed: () => _showMyDialog(
                    context,
                    onConfirm: () =>
                        context.read<AuthBloc>().add(AuthLogoutRequested()),
                    label: 'Do you want to logout ?',
                  ),
                  child: const Text(
                    'LOGOUT',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  height: 25.0,
                  width: 75.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                    ),
                    onPressed: () => _showMyDialog(
                      context,
                      onConfirm: () =>
                          context.read<AuthBloc>().add(DeleteAccount()),
                      label: 'Do you want to delete your account ?',
                    ),
                    child: const Text('CLOSE'),
                  ),
                ),
                const SizedBox(height: 35.0),
                Image.asset(
                  'assets/images/image_smallest.png',
                  height: 30.0,
                  width: 30.0,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'v0.1',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'save the world',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import '/screens/account/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class UpdateAccount extends StatelessWidget {
  static const String routeName = '/updateAccount';
  const UpdateAccount({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const UpdateAccount(),
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
          'UPDATE',
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
              children: [
                const SizedBox(height: 50.0),
                Center(
                  child: Image.asset(
                    'assets/images/profile_personal.png',
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'PERSONAL',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Please add you bio here and personal info',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40.0),
                CustomTextField(
                  hintText: 'NONE',
                  labelText: 'AGE',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  hintText: 'NONE',
                  labelText: 'GENDER',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  hintText: 'NONE',
                  labelText: 'LANGUAGE',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  hintText: 'NONE',
                  labelText: 'RELATIONSHIP',
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

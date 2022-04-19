import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

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
            onPressed: () {},
          ),
        ),
        title: const Text(
          'NOTIFICATIONS',
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
                    'assets/images/notifications.png',
                    height: 64.0,
                    width: 64.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'NEW SETTERS',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'If you turn off the below options, you\nwill not be able to see your NEW SETTERS.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                OptionButtons(
                  label: 'PUSH NOTIFICATIONS',
                  onTap: () {},
                ),
                const SizedBox(height: 10.0),
                OptionButtons(
                  label: 'EMAIL NOTIFICATIONS',
                  onTap: () {},
                ),
                const SizedBox(height: 100.0),
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

class OptionButtons extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const OptionButtons({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      width: double.infinity,
      child: Card(
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

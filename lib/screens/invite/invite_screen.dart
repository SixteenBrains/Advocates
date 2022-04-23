import 'package:advocates/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({Key? key}) : super(key: key);

  void invite() {
    Share.share('check out this awesome app https://example.com', subject: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'INVITE',
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
                    'assets/images/account_invite.png',
                    height: 64.0,
                    width: 64.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'INVITE',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                          text:
                              '   Share your invite link with friends to build your\n'),
                      TextSpan(text: 'first '),
                      TextSpan(
                        text: 'BITCOIN CREDIT SCORE',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' the first in the world.'),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                OptionButtons(
                  label: 'MESSENGER',
                  onTap: invite,
                ),
                const SizedBox(height: 10.0),
                OptionButtons(
                  label: 'WHATSAPP',
                  onTap: invite,
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 75.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff2ED573),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(
                          text:
                              'check out this awesome app https://example.com'));
                      ShowSnackBar.showSnackBar(context,
                          title: 'Copied to clipboard');
                    },
                    child: const Text(
                      'COPY',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
        ),
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

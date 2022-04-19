import '/screens/account/invite.dart';
import 'package:flutter/material.dart';

class Cause extends StatelessWidget {
  const Cause({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const Invite(),
            ),
          );
        },
      ),
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
          'CAUSES',
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
                    'assets/images/preference_cause.png',
                    height: 64.0,
                    width: 64.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  '{ 0 }',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Kindly select the causes that matter\nto you, you can select up to 5 causes.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                OptionButtons(
                  label: 'ABUSE',
                  onTap: () {},
                ),
                const SizedBox(height: 10.0),
                OptionButtons(
                  label: 'ANIMAL',
                  onTap: () {},
                ),
                const SizedBox(height: 10.0),
                OptionButtons(
                  label: 'CLIMATE',
                  onTap: () {},
                ),
                const SizedBox(height: 15.0),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
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
                    onPressed: () {},
                    child: const Text('CLOSE'),
                  ),
                ),
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
    return Container(
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
    );
  }
}

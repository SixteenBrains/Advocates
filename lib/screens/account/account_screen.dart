import '/screens/account/update_account.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = '/account';
  const AccountScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AccountScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 180.0,
                  child: Stack(
                    children: [
                      Container(
                        height: 60.0,
                        color: Colors.white,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/menu_format.png',
                                height: 40.0,
                                width: 40.0,
                              ),
                              Image.asset(
                                'assets/images/menu_cause.png',
                                height: 40.0,
                                width: 40.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        //  top: 10.0,
                        alignment: Alignment.topCenter,

                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: CircleAvatar(
                            radius: 70.0,
                            backgroundColor: Colors.grey.shade300,
                            // child: Image.asset('assets/images/image_bigger.png'),
                            child: Icon(
                              Icons.person,
                              size: 140.0,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 105.0,
                        bottom: 0.0,
                        top: 20.0,
                        child: CircleAvatar(
                          radius: 18.0,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/images/Group 636.png',
                            height: 30.0,
                            width: 30.0,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10.0,
                        right: 0.0,
                        left: 70.0,
                        child: Transform(
                          transform: Matrix4.identity()..scale(0.8),
                          child: const Chip(
                            backgroundColor: Color(0xff2ED573),
                            label: Text(
                              '20%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Rishu Kumar',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CoinStats(
                      /// color: Color(0XffF7F7F7),
                      coinImg: 'assets/images/wallet_set.png',
                      coinLabel: 'SET',
                    ),
                    CoinStats(
                      /// color: Color(0XffF7F7F7),
                      coinImg: 'assets/images/wallet_btc.png',
                      coinLabel: 'BTC',
                    ),
                    CoinStats(
                      coinImg: 'assets/images/wallet_eth.png',
                      coinLabel: 'ETH',
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 25.0),
                      const Text(
                        '000',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text('improve your credit score'),
                      // We can user dots_indicator package here
                      const SizedBox(height: 30.0),
                      SizedBox(
                        height: 25.0,
                        width: 75.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff2ED573),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                16.0,
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(UpdateAccount.routeName),
                          child: const Text('BOOST'),
                        ),
                      ),
                      const SizedBox(height: 45.0),
                    ],
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

class CoinStats extends StatelessWidget {
  final String coinLabel;
  final String coinImg;
  final Color? color;

  const CoinStats({
    Key? key,
    required this.coinLabel,
    required this.coinImg,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        height: 150.0,
        width: 112.0,
        child: Column(
          children: [
            const SizedBox(height: 15.0),
            const Text('-0%'),
            const SizedBox(height: 5.0),
            const Text(
              '000',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text('SET'),
            const SizedBox(height: 8.0),
            Image.asset(
              coinImg,
              height: 40.0,
              width: 40.0,
            )
          ],
        ),
      ),
    );
  }
}

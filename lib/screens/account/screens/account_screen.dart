import 'package:advocates/screens/account/widgets/invite_advocates.dart';
import 'package:advocates/screens/settings/settings_screen.dart';

import '/screens/account/screens/cause_screen.dart';
import '/screens/account/screens/formate_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import '/widgets/display_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'update_account.dart';
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
    final _authBloc = context.read<AuthBloc>();
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(FormateScreen.routeName),
                              child: Image.asset(
                                'assets/images/menu_format.png',
                                height: 40.0,
                                width: 40.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(CauseScreen.routeName),
                              child: Image.asset(
                                'assets/images/menu_cause.png',
                                height: 40.0,
                                width: 40.0,
                              ),
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
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(UpdateAccount.routeName),
                            child: ClipOval(
                              child: DisplayImage(
                                imageUrl: _authBloc.state.user?.profilePic,
                              ),
                            ),
                          ),

                          //     Icon(
                          //   Icons.person,
                          //   size: 140.0,
                          //   color: Colors.grey.shade500,
                          // ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 105.0,
                      bottom: 0.0,
                      top: 20.0,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(SettingsScreen.routeName),
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
              Text(
                _authBloc.state.user?.name ?? 'N/A',
                //'Rishu Kumar',
                style: const TextStyle(
                  fontSize: 24.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
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
              ),
              const SizedBox(height: 20.0),
              const InviteAdvocates(),
              const SizedBox(height: 20.0),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //   child: Container(
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //     child: Column(
              //       children: [
              //         const SizedBox(height: 25.0),
              //         const Text(
              //           '000',
              //           style: TextStyle(
              //             fontSize: 32.0,
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //         const Text('improve your credit score'),
              //         // We can user dots_indicator package here
              //         const SizedBox(height: 30.0),
              //         SizedBox(
              //           height: 25.0,
              //           width: 75.0,
              //           child: ElevatedButton(
              //             style: ElevatedButton.styleFrom(
              //               primary: const Color(0xff2ED573),
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(
              //                   16.0,
              //                 ),
              //               ),
              //             ),
              //             onPressed: () => Navigator.of(context)
              //                 .pushNamed(UpdateAccount.routeName),
              //             child: const Text('BOOST'),
              //           ),
              //         ),
              //         const SizedBox(height: 45.0),
              //       ],
              //     ),
              //   ),
              // ),
            ],
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

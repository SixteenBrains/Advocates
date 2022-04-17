import '/widgets/loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/signup_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const String routeName = '/signup';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => SignUpCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: const SignUpScreen(),
      ),
    );
  }

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName,
      [double width = 170.0, double height = 170.0]) {
    return Image.asset(
      'assets/$assetName',
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    //const bodyStyle = TextStyle(fontSize: 19.0);
    final _canvas = MediaQuery.of(context).size;

    // const pageDecoration = PageDecoration(
    //   titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    //   bodyTextStyle: bodyStyle,
    //   bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    //   pageColor: Colors.white,
    //   imagePadding: EdgeInsets.zero,
    // );

    void _onIntroEnd(context) {}

    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == SignupStatus.submitting) {
            return const LoadingIndicator();
          }
          return IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.white,

            pages: [
              PageViewModel(
                title: '',
                bodyWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    Image.asset(
                      'assets/images/splash_prize.png',
                      width: 170.0,
                      height: 170.0,
                    ),
                    const SizedBox(height: 50.0),
                    const Text(
                      'BITCOIN CREDIT',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text:
                                  'The credit system in your country is either dead\nor broken, build your first '),
                          TextSpan(
                            text: 'BITCOIN CREDIT SCORE.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    SizedBox(
                      height: 50.0,
                      width: 220.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2ED573),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        onPressed: () =>
                            context.read<SignUpCubit>().singupWithGoogle(),
                        child: Center(
                          child: Image.asset(
                            'assets/images/google_icon.png',
                            height: 30.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        'By signing up, you agree with our terms and\npolicies on https/setment.com/legal/terms',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                decoration: const PageDecoration(
                  titleTextStyle: TextStyle(
                    color: Color(0xff4A4980),
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                  imageAlignment: Alignment.center,
                  //imagePadding: const EdgeInsets.only(top: 100.0),
                ),
              ),
              PageViewModel(
                title: '',
                bodyWidget: Text(
                  'Maximum reach and conversions from the minimum investment',
                  style: GoogleFonts.openSans(
                    color: const Color(0xff4A4980),
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                decoration: PageDecoration(
                  titleTextStyle: GoogleFonts.openSans(
                    color: const Color(0xff4A4980),
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                  imageAlignment: Alignment.center,
                  // imagePadding: const EdgeInsets.only(top: 100.0),
                ),
                image: _buildImage('Group 67.png'),
              ),
            ],
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: false,
            skipOrBackFlex: 0,
            nextFlex: 0,
            showDoneButton: false,
            showNextButton: false, showBackButton: false,
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(12.0)
                : EdgeInsets.fromLTRB(8.0, 4.0, 8.0, _canvas.height * 0.1),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeColor: Color(0xff4243E6),
              activeSizes: [
                Size(15.0, 15.0),
                Size(15.0, 15.0),
              ],
            ),
            dotsContainerDecorator: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          );
        },
      ),
    );
  }
}

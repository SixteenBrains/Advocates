import '/widgets/loading_indicator.dart';
import 'package:flutter/foundation.dart';
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

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

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
              // Second
              PageViewModel(
                title: '',
                bodyWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    Image.asset(
                      'assets/images/splash_credit_card.png',
                      width: 170.0,
                      height: 170.0,
                    ),
                    const SizedBox(height: 50.0),
                    const Text(
                      'BITCOIN CARD',
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
                          TextSpan(text: 'Use your '),
                          TextSpan(
                            text: 'BITCOIN CREDIT SCORE ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: 'to qualify for our '),
                          TextSpan(
                            text: '\nBITCOIN GIFT CARD ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: 'regardless of your nationality'),
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

              //third
              PageViewModel(
                title: '',
                bodyWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    Image.asset(
                      'assets/images/splash_investment.png',
                      width: 170.0,
                      height: 170.0,
                    ),
                    const SizedBox(height: 50.0),
                    const Text(
                      'BITCOIN INCOME',
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
                          TextSpan(text: 'Your '),
                          TextSpan(
                            text: 'BITCOIN CREDIT SCORE.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'might also qualify\nyou for the world\'s fitst '),
                          TextSpan(
                            text: 'BITCOIN BASIC INCOME.',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
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

            dotsDecorator: DotsDecorator(
              color: Colors.grey.shade300,
              size: const Size(10, 5),
              activeSize: const Size(20, 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              activeColor: Colors.black,
            ),

            // dotsDecorator: DotsDecorator(
            //   size: const Size(15.0, 5.0),
            //   color: Colors.grey.shade300,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10)),
            //   // activeSize: const Size(22.0, 10.0),
            //   activeSize: const Size(5.0, 50.0),
            //   // activeSize: const Size(50.0, 5.0),
            //   activeColor: Colors.black,
            //   activeSizes: const [
            //     // Size(15.0, 15.0),
            //     Size(5.0, 5.0),
            //     Size(5.0, 5.0),
            //     Size(5.0, 5.0),
            //     //Size(15.0, 15.0),
            //     // Size(15.0, 15.0),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}

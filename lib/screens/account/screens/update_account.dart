import 'package:advocates/screens/account/widgets/education_info.dart';
import 'package:advocates/screens/account/widgets/location_info.dart';
import 'package:advocates/screens/account/widgets/professional_info.dart';

import '/screens/account/widgets/personal_info.dart';
import 'package:flutter/foundation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '/screens/account/cubit/account_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

const pageDecoration = PageDecoration(
  titleTextStyle: TextStyle(
    color: Color(0xff4A4980),
    fontSize: 25.0,
    fontWeight: FontWeight.w600,
  ),
  imageAlignment: Alignment.center,
);

class UpdateAccount extends StatefulWidget {
  static const String routeName = '/updateAccount';
  const UpdateAccount({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const UpdateAccount(),
    );
  }

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) {}
  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

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
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {},
        builder: (context, state) {
          return IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.white,
            pages: [
              PageViewModel(
                // title: '',
                titleWidget: const PersonalInfo(),
                body: '',
                decoration: pageDecoration,
              ),
              PageViewModel(
                titleWidget: const ProfessionalInfo(),
                body: '',
                decoration: pageDecoration,
              ),
              PageViewModel(
                titleWidget: const LocationInfo(),
                body: '',
                decoration: pageDecoration,
              ),
              PageViewModel(
                titleWidget: const EducationInfo(),
                body: '',
                decoration: pageDecoration,
              ),
            ],
            controlsPosition: const Position(left: 0, right: 0, top: 0),
            onDone: () => _onIntroEnd(context),
            showSkipButton: false,
            skipOrBackFlex: 0,
            nextFlex: 0,
            showDoneButton: false,
            showNextButton: false,
            showBackButton: false,
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
          );
        },
      ),
    );
  }
}

import 'package:advocates/widgets/show_snackbar.dart';

import '/blocs/auth/auth_bloc.dart';
import '/widgets/loading_indicator.dart';
import '/repositories/profile/profile_repository.dart';
import '/screens/update-account/cubit/update_account_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'widgets/education_info.dart';
import 'widgets/location_info.dart';
import 'widgets/personal_info.dart';
import 'widgets/professional_info.dart';

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
      builder: (_) => BlocProvider(
        create: (context) => UpdateAccountCubit(
          profileRepository: context.read<ProfileRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..loadAccountDetails(),
        child: const UpdateAccount(),
      ),
    );
  }

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) {}

  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      context.read<UpdateAccountCubit>().submitDetails();
      ShowSnackBar.showSnackBar(context,
          title: 'Account updated', backgroundColor: Colors.green);
      Navigator.of(context).pop();
    } else {
      ShowSnackBar.showSnackBar(context,
          title: 'Account updated', backgroundColor: Colors.green);
    }
  }

  final _formKey = GlobalKey<FormState>();

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
      body: BlocConsumer<UpdateAccountCubit, UpdateAccountState>(
        listener: (context, state) {
          if (state.status == UpdateAccountStatus.error) {
            ShowSnackBar.showSnackBar(context,
                title: state.errorMsg,
                backgroundColor: Colors.deepOrangeAccent);
          }
        },
        builder: (context, state) {
          if (state.status == UpdateAccountStatus.loading) {
            return const LoadingIndicator();
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: _canvas.height,
              child: Form(
                key: _formKey,
                child: IntroductionScreen(
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
                      titleWidget: EducationInfo(
                        onSubmit: () {
                          _submit(context);
                        },
                      ),
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
                      : EdgeInsets.fromLTRB(
                          8.0, 4.0, 8.0, _canvas.height * 0.1),
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

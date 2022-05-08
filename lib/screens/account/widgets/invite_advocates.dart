import '/enums/nav_item.dart';
import '/screens/account/cubit/account_cubit.dart';
import '/widgets/loading_indicator.dart';
import '/screens/nav/bloc/nav_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

const pageDecoration = PageDecoration(
  titleTextStyle: TextStyle(
    color: Color(0xff4A4980),
    fontSize: 25.0,
    fontWeight: FontWeight.w600,
  ),
  imageAlignment: Alignment.center,
);

class InviteAdvocates extends StatefulWidget {
  const InviteAdvocates({Key? key}) : super(key: key);

  @override
  State<InviteAdvocates> createState() => _InviteAdvocatesState();
}

class _InviteAdvocatesState extends State<InviteAdvocates> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {}
  @override
  void initState() {
    context.read<AccountCubit>().getAdvocatesCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == AccountStatus.loading) {
          return const LoadingIndicator();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            height: 240,
            child: IntroductionScreen(
              key: introKey,
              globalBackgroundColor: Colors.white,
              pages: [
                PageViewModel(
                  // title: '',
                  titleWidget: InviteCard(
                    btnText: 'INVITE',
                    label: 'invite more advocates',
                    inviteCount: state.advocatesCount,
                  ),
                  body: '',
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  // title: '',
                  titleWidget: const InviteCard(
                    btnText: 'BOOST',
                    label: 'boost your score',
                    inviteCount: null,
                  ),
                  body: '',
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  // title: '',
                  titleWidget: const InviteCard(
                    btnText: 'EARN',
                    label: 'earn more income',
                    inviteCount: null,
                  ),
                  body: '',
                  decoration: pageDecoration,
                ),
              ],
              controlsPosition: const Position(left: 0, right: 0, bottom: 10),
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
            ),
          ),
        );
      },
    );
  }
}

class InviteCard extends StatelessWidget {
  final int? inviteCount;
  final String label;
  final String btnText;

  const InviteCard({
    Key? key,
    this.inviteCount,
    required this.label,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            '${inviteCount ?? 000}',
            //inviteCount.toString(),
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          // We can user dots_indicator package here
          const SizedBox(height: 50.0),
          SizedBox(
            height: 26.0,
            width: 76.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff2ED573),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () => context
                  .read<NavBloc>()
                  .add(const UpdateNavItem(item: NavItem.invite)),
              child: Text(
                btnText,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}

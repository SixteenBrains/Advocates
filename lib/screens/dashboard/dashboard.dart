import 'package:avatar_glow/avatar_glow.dart';
import '/screens/account/screens/cause_screen.dart';
import '/screens/account/screens/formate_screen.dart';
import '/screens/dashboard/bloc/dashboard_bloc.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/swiping_subset.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    context.read<DashboardBloc>().add(InitSpeachToText());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60.0,
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
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
                    Image.asset(
                      'assets/images/image_smallest.png',
                      height: 32.0,
                      width: 32.0,
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
            const SizedBox(height: 10.0),
            Expanded(
              child: BlocConsumer<DashboardBloc, DashBoardState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == DashBoardStatus.loading) {
                    return const LoadingIndicator();
                  }

                  // final searchKeyword = state.searchKeyword != null
                  //     ? state.searchKeyword!.length > 16
                  //         ? state.searchKeyword?.substring(0, 15)
                  //         : state.searchKeyword
                  //     : 'Hold and speak';

                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: RefreshIndicator(
                            onRefresh: () async => context
                                .read<DashboardBloc>()
                                .add(LoadSubSets()),
                            child: state.subSets.isEmpty
                                ? const Center(
                                    child: Text('No sets found, try again'))
                                : SwippingSubSet(subSets: state.subSets)

//                                   : SwipeCards(
//             matchEngine: <MatchEngine>,
//             itemBuilder: (BuildContext context, int index) {},
//             onStackFinished: () {},
//             itemChanged: (SwipeItem item, int index) {},
//             upSwipeAllowed: <bool>,
//             fillSpace: <bool>,
// )

                            // : InViewNotifierList(
                            //     initialInViewIds: const ['0'],

                            //     //                         inViewPortCondition:
                            //     //     (double deltaTop, double deltaBottom, double vpHeight) {
                            //     //   return (deltaTop < (0.5 * vpHeight) + 100.0 &&
                            //     //       deltaBottom > (0.5 * vpHeight) - 100.0);
                            //     // },
                            //     itemCount: state.subSets.length,
                            //     isInViewPortCondition: (double deltaTop,
                            //         double deltaBottom, double vpHeight) {
                            //       return (deltaTop <
                            //               (0.5 * vpHeight) + 100.0 &&
                            //           deltaBottom > (0.5 * vpHeight) - 100.0);
                            //     },

                            //     builder: (context, index) {
                            //       final subSet = state.subSets[index];

                            //       return InViewNotifierWidget(
                            //         id: '$index',
                            //         builder: (context, inView, _) {
                            //           print('Inview $inView $index');

                            //           if (inView) {
                            //             print('print this taa');

                            //             context
                            //                 .read<SetCubit>()
                            //                 .increaseViews(
                            //                     subSetId: subSet?.subSetId);
                            //           }

                            //           return SubSetCard(subSet: subSet);
                            //         },
                            //       );
                            //     },
                            //   ),
                            ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onLongPress: () {
                            context.read<DashboardBloc>().add(ListenToSpeech());
                            print('User have started the tap');
                          },
                          onLongPressEnd: (details) {
                            print('User have compled the tap');
                            context.read<DashboardBloc>().add(LoadSubSets());
                          },
                          // onTap: () {
                          //   // context.read<DashboardBloc>().add(LoadSubSets());
                          //   //  context.read<DashboardBloc>().add(ListenToSpeech());
                          // },
                          child: AvatarGlow(
                            shape: BoxShape.circle,
                            // animate: isListen,
                            animate: true,
                            glowColor: Colors.green,
                            // endRadius: (_lastWords.length * 6.0).toDouble(),
                            endRadius: 65.0,
                            duration: const Duration(milliseconds: 2000),
                            repeatPauseDuration:
                                const Duration(milliseconds: 100),
                            repeat: true,
                            child: Text(
                              // textString,
                              state.searchKeyword ?? 'Hold and speak',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      // if (state.searchKeyword != null)
                      //   Align(
                      //     alignment: Alignment.bottomRight,
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 25.0, vertical: 10.0),
                      //       child: CircleAvatar(
                      //         backgroundColor: Colors.white,
                      //         child: IconButton(
                      //           onPressed: () {
                      //             context
                      //                 .read<DashboardBloc>()
                      //                 .add(LoadSubSets());
                      //           },
                      //           icon: const Icon(Icons.search,
                      //               color: Colors.green),
                      //         ),
                      //       ),
                      //     ),
                      //   )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

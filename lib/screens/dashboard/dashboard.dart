import '/enums/nav_item.dart';
import '/screens/nav/bloc/nav_bloc.dart';
import '/screens/account/screens/cause_screen.dart';
import '/screens/account/screens/formate_screen.dart';
import '/screens/dashboard/bloc/dashboard_bloc.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

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
                  Image.asset(
                    'assets/images/image_smallest.png',
                    height: 32.0,
                    width: 32.0,
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(CauseScreen.routeName),
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
          const SizedBox(height: 20.0),
          Expanded(
            child: BlocConsumer<DashboardBloc, DashBoardState>(
              listener: ((context, state) {}),
              builder: (context, state) {
                if (state.status == DashBoardStatus.loading) {
                  return const LoadingIndicator();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: ListView.builder(
                    itemCount: state.sets.length,
                    itemBuilder: (context, index) {
                      //final set = state.sets[index];
                      return Container(
                        height: 470.0,
                        //constraints: BoxConstraints.loose(Size(1, 1)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black12,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 40.0),
                            CircleAvatar(
                              radius: 90.0,
                              backgroundColor: Colors.grey.shade600,
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                StatsWidget(
                                  iconUrl: 'assets/images/set_views.png',
                                  label: 'VIEWS',
                                ),
                                StatsWidget(
                                  iconUrl: 'assets/images/set_likes.png',
                                  label: 'LIKES',
                                ),
                                StatsWidget(
                                  iconUrl: 'assets/images/set_visits.png',
                                  label: 'VISITS',
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                              height: 52.0,
                              width: 200.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff2ED573),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                ),
                                onPressed: () => context.read<NavBloc>().add(
                                    const UpdateNavItem(item: NavItem.sets)),
                                child: const Text(
                                  'CREATE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // CircleAvatar(
                        //   radius: 30.0,
                        // ),
                      );

                      // SizedBox(
                      //   height: 400.0,
                      //   child: Card(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20.0),
                      //     ),
                      //     child: Stack(
                      //       fit: StackFit.expand,
                      //       children: [
                      //         ClipRRect(
                      //           borderRadius: BorderRadius.circular(20.0),
                      //           child: Image.network(
                      //             set?.subsets[0]?.imageUrl ?? '',
                      //             fit: BoxFit.cover,
                      //           ),
                      //         ),
                      //         Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(20.0),
                      //             color: Colors.black26,
                      //           ),
                      //         ),
                      //         Align(
                      //           alignment: Alignment.bottomLeft,
                      //           child: Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //               horizontal: 10.0,
                      //               vertical: 10.0,
                      //             ),
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.end,
                      //               children: [
                      //                 Text(
                      //                   set?.subsets[0]?.description ?? 'N/A',
                      //                   style: const TextStyle(
                      //                     fontSize: 16.0,
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.w600,
                      //                   ),
                      //                 ),
                      //                 Chip(
                      //                   backgroundColor:
                      //                       const Color(0xff2ED573),
                      //                   label: Text(
                      //                     set?.cause ?? 'N/A',
                      //                     style: const TextStyle(
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.w600,
                      //                       letterSpacing: 1.0,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Text(
                      //                   set?.subsets[0]?.destination ?? 'N/A',
                      //                   style: const TextStyle(
                      //                     color: Colors.white,
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class StatsWidget extends StatelessWidget {
  final String iconUrl;
  final String label;

  const StatsWidget({
    Key? key,
    required this.iconUrl,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 108.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(8.0),
      ),
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
          Text(label),
          const SizedBox(height: 8.0),
          Image.asset(
            iconUrl,
            height: 40.0,
            width: 40.0,
          )
        ],
      ),
    );
  }
}

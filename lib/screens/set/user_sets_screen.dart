import '/screens/set/set_manager.dart';
import '/screens/set/cubit/set_cubit.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/account/screens/cause_screen.dart';
import '/screens/account/screens/formate_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/set_card.dart';

class UserSetsScreen extends StatelessWidget {
  const UserSetsScreen({Key? key}) : super(key: key);

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
                    const Text(
                      'SETS',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
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
            const SizedBox(height: 20.0),
            Expanded(
              child: BlocConsumer<SetCubit, SetState>(
                listener: (context, state) {
                  if (state.status == SetStatus.succuss) {
                    if (state.sets.isEmpty) {
                      Navigator.of(context).pushNamed(SetManager.routeName);
                    }
                  }
                },
                builder: (context, state) {
                  if (state.status == SetStatus.loading) {
                    return const LoadingIndicator();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async =>
                          context.read<SetCubit>().loadUserSets(),
                      child: ListView.builder(
                        itemCount: state.sets.length,
                        itemBuilder: (context, index) {
                          final setModel = state.sets[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: SetCard(
                              setModel: setModel,
                              onDelete: () => context
                                  .read<SetCubit>()
                                  .deleteSet(setId: setModel?.setId),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

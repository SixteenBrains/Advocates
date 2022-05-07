import '/repositories/account/account_repository.dart';
import '/widgets/options_button.dart';
import '/blocs/auth/auth_bloc.dart';
import '/constants/constants.dart';
import '/screens/account/cubit/account_cubit.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CauseScreen extends StatelessWidget {
  static const String routeName = '/cause';
  const CauseScreen({Key? key}) : super(key: key);

  void _submitCauses(BuildContext context) {
    context.read<AccountCubit>().submitCause();
  }

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => AccountCubit(
          authBloc: context.read<AuthBloc>(),
          accountRepository: context.read<AccountRepository>(),
        )..loadSelectedCauses(),
        child: const CauseScreen(),
      ),
    );
  }

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
          'CAUSES',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state.status == AccountStatus.submitted) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state.status == AccountStatus.loading) {
            return const LoadingIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                Center(
                  child: Image.asset(
                    'assets/images/preference_cause.png',
                    height: 64.0,
                    width: 64.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '{ ${state.causes.length} }',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Kindly select the causes that matter\nto you, you can select up to 5 causes.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  height: _canvas.height * 0.38,
                  child: ListView.builder(
                    itemCount: causes.length,
                    itemBuilder: (context, index) {
                      final cause = causes[index];
                      final isSelected = state.causes.contains(cause);

                      return OptionsButton(
                        label: cause,
                        isSelected: isSelected,
                        onTap: () {
                          if (isSelected) {
                            context.read<AccountCubit>().removeCause(cause);
                          } else {
                            context.read<AccountCubit>().addCause(cause);
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15.0),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 25.0,
                  width: 75.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                    ),
                    onPressed: () => _submitCauses(context),
                    child: const Text('CLOSE'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

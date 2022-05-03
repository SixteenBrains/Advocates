import '/widgets/loading_indicator.dart';
import '/screens/update-account/cubit/update_account_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EducationInfo extends StatefulWidget {
  final VoidCallback onSubmit;
  const EducationInfo({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<EducationInfo> createState() => _EducationInfoState();
}

class _EducationInfoState extends State<EducationInfo> {
  @override
  Widget build(BuildContext context) {
    final _authBloc = context.read<AuthBloc>();
    final _accountCubit = context.read<UpdateAccountCubit>();
    return BlocConsumer<UpdateAccountCubit, UpdateAccountState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == UpdateAccountStatus.loading) {
          return const LoadingIndicator();
        }
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                Center(
                  child: Image.asset(
                    'assets/images/profile_personal.png',
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'EDUCATION',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${_authBloc.state.user?.name}\'s academic background',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  initialValue: state.lavel,
                  hintText: 'NONE',
                  labelText: 'LEVEL',
                  onChanged: (value) => _accountCubit.levelChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Level cant\'t be empty');
                      return 'Level cant\'t be empty';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 25.0),
                CustomTextField(
                  initialValue: state.award,
                  hintText: 'NONE',
                  labelText: 'AWARD',
                  onChanged: (value) => _accountCubit.awardChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Award cant\'t be empty');
                      return 'Award cant\'t be empty';
                    }
                    return null;
                  },
                ),
                //  const SizedBox(height: 25.0),
                CustomTextField(
                  initialValue: state.graduation,
                  hintText: 'NONE',
                  labelText: 'GRADUATION',
                  onChanged: (value) => _accountCubit.graduationChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit
                          .addErrorMessage('Graduation cant\'t be empty');
                      return 'Graduation cant\'t be empty';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  initialValue: state.graduation,
                  hintText: 'NONE',
                  labelText: 'DURATION',
                  onChanged: (value) => _accountCubit.durationChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit
                          .addErrorMessage('Duration cant\'t be empty');
                      return 'Duration cant\'t be empty';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20.0),
                SizedBox(
                  height: 42.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => widget.onSubmit(),
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

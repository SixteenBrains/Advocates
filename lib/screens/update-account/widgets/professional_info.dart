import '/screens/update-account/cubit/update_account_cubit.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/custom_textfield.dart';
import '/blocs/auth/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalInfo extends StatelessWidget {
  const ProfessionalInfo({Key? key}) : super(key: key);

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
                  'PROFESSION',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${_authBloc.state.user?.name}\'s professional information',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'ROLE',
                  onChanged: (value) => _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Age cant\'t be empty');
                      return 'Role cant\'t be empty';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 25.0),
                CustomTextField(
                  initialValue: state.title,
                  hintText: 'NONE',
                  labelText: 'TITLE',
                  onChanged: (value) => _accountCubit.titleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Title cant\'t be empty');
                      return 'Title cant\'t be empty';
                    }
                    return null;
                  },
                ),
                //  const SizedBox(height: 25.0),
                CustomTextField(
                  initialValue: state.industry,
                  hintText: 'NONE',
                  labelText: 'INDUSTRY',
                  onChanged: (value) => _accountCubit.industryChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit
                          .addErrorMessage('Industry cant\'t be empty');
                      return 'Industry cant\'t be empty';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  initialValue: state.skill,
                  hintText: 'NONE',
                  labelText: 'SKILL',
                  onChanged: (value) => _accountCubit.skillChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Skill cant\'t be empty');
                      return 'Skill cant\'t be empty';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

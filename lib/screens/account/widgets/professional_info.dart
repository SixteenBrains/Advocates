import '/blocs/auth/auth_bloc.dart';
import '/screens/account/cubit/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_textfield.dart';

class ProfessionalInfo extends StatelessWidget {
  const ProfessionalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = context.read<AuthBloc>();
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2.0,
            ),
            child: SingleChildScrollView(
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
                    hintText: 'NONE',
                    labelText: 'ROLE',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Role cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 25.0),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'TITLE',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Title cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  //  const SizedBox(height: 25.0),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'INDUSTRY',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Industry cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'SKILL',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Skill cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import '/blocs/auth/auth_bloc.dart';
import '/screens/account/cubit/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_textfield.dart';

class EducationInfo extends StatelessWidget {
  const EducationInfo({Key? key}) : super(key: key);

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
                    hintText: 'NONE',
                    labelText: 'LEVEL',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Level cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 25.0),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'AWARD',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Award cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  //  const SizedBox(height: 25.0),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'GRADUATION',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Graduation cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'DURATION',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Duration cant\'t be empty';
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

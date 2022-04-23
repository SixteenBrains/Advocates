import '/blocs/auth/auth_bloc.dart';
import '/screens/account/cubit/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_textfield.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({Key? key}) : super(key: key);

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
                    'LOCATION',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '${_authBloc.state.user?.name}\'s geographical details',
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'REGION',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Region cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 25.0),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'COUNTRY',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Country cant\'t be empty';
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
                    labelText: 'STATE',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'State cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'CITY',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'City cant\'t be empty';
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

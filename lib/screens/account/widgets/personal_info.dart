import 'package:advocates/blocs/auth/auth_bloc.dart';
import 'package:advocates/constants/constants.dart';
import 'package:advocates/screens/account/cubit/account_cubit.dart';
import 'package:advocates/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_textfield.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

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
                    'PERSONAL',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '${_authBloc.state.user?.name}\'s personal information',
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextField(
                    hintText: 'NONE',
                    labelText: 'AGE',
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Age cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 25.0),
                  CustomDropDown(
                    labelText: 'GENDER',
                    dropDownOptions: gender,
                    onChanged: (value) =>
                        context.read<AccountCubit>().genderChanged(value),
                    selectedValue: state.selectedGender,
                  ),
                  //  const SizedBox(height: 25.0),
                  CustomDropDown(
                    labelText: 'LANGUAGE',
                    dropDownOptions: languages,
                    onChanged: (value) =>
                        context.read<AccountCubit>().languageChanged(value),
                    selectedValue: state.selectedLanguage,
                  ),
                  // const SizedBox(height: 25.0),
                  CustomDropDown(
                    labelText: 'RELATIONSHIP',
                    dropDownOptions: relationShipStatus,
                    onChanged: (value) => context
                        .read<AccountCubit>()
                        .relationShipStatusChanged(value),
                    selectedValue: state.relationShipStatus,
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

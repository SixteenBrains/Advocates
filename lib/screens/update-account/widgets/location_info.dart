import '/widgets/loading_indicator.dart';

import '/screens/update-account/cubit/update_account_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({Key? key}) : super(key: key);

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
                  initialValue: state.region,
                  hintText: 'NONE',
                  labelText: 'REGION',
                  onChanged: (value) => _accountCubit.regionChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Region cant\'t be empty');
                      return 'Region cant\'t be empty';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 25.0),
                CustomTextField(
                  initialValue: state.country,
                  hintText: 'NONE',
                  labelText: 'COUNTRY',
                  onChanged: (value) => _accountCubit.countryChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Country cant\'t be empty');
                      return 'Country cant\'t be empty';
                    }
                    return null;
                  },
                ),
                //  const SizedBox(height: 25.0),

                CustomTextField(
                  initialValue: state.state,
                  hintText: 'NONE',
                  labelText: 'STATE',
                  onChanged: (value) => _accountCubit.stateChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('State cant\'t be empty');
                      return 'State cant\'t be empty';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  initialValue: state.city,
                  hintText: 'NONE',
                  labelText: 'CITY',
                  onChanged: (value) => _accountCubit.cityChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('City cant\'t be empty');
                      return 'City cant\'t be empty';
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

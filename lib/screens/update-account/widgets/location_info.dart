import 'package:advocates/constants/constants.dart';

import '/widgets/loading_indicator.dart';

import '/screens/update-account/cubit/update_account_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_account_field.dart';

class LocationInfo extends StatefulWidget {
  final String? region;
  final String? country;
  final String? state;
  final String? city;

  const LocationInfo({Key? key, required this.region, required this.country,required this.state,required this.city,}) : super(key: key);

  @override
  State<LocationInfo> createState() => _LocationInfoState();
}

class _LocationInfoState extends State<LocationInfo> {
final _regionController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void initState() {
    _regionController.text = widget.region ?? '';
    _countryController.text = widget.country ?? '';
    _stateController.text = widget.state ?? '';
    _cityController.text = widget.city?? '';


    super.initState();
  }

  @override
  void dispose() {
    _regionController.dispose();
     _countryController.dispose();
     _stateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

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

                UpdateAccountField(
                  controller: _regionController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'REGION',
                  onChanged: (value) {
                    final regionFound = region.firstWhere(
                            (element) =>
                            element.toLowerCase().startsWith(value.toLowerCase()),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();
                    if (regionFound.isNotEmpty) {
                      print('Value - $value');
                      print('Region Found $regionFound');
                      _regionController.text = regionFound;
                      _accountCubit.regionChanged(regionFound);
                      _regionController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _regionController.text.length));
                    }
                    print('Gender found $regionFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Region cant\'t be empty');
                      return 'Region cant\'t be empty';
                    }
                    return null;
                  },
                ),
//
                UpdateAccountField(
                  controller: _countryController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'COUNTRY',
                  onChanged: (value) {
                    final countryFound = country.firstWhere(
                            (element) =>
                            element.toLowerCase() .startsWith(value.toLowerCase()),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();



                    if (countryFound.isNotEmpty) {
                      _countryController.text = countryFound;
                      _accountCubit.countryChanged(countryFound);
                      _countryController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _countryController.text.length));
                    }
                    print('Gender found $countryFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Country cant\'t be empty');
                      return 'Country cant\'t be empty';
                    }
                    return null;
                  },
                ),

                UpdateAccountField(
                  controller: _stateController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'STATE',
                  onChanged: (value) {
                    final stateFound = states.firstWhere(
                            (element) =>
                            element.toLowerCase() .startsWith(value),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();

                    if (stateFound.isNotEmpty) {
                      _stateController.text = stateFound;
                      _accountCubit.countryChanged(stateFound);
                      _stateController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _stateController.text.length));
                    }
                    print('State found $stateFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('State cant\'t be empty');
                      return 'State cant\'t be empty';
                    }
                    return null;
                  },
                ),


                UpdateAccountField(
                  controller: _cityController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'CITY',
                  onChanged: (value) {
                    final cityFound = cities.firstWhere(
                            (element) =>
                            element.toLowerCase().startsWith(value),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();

                    if (cityFound.isNotEmpty) {
                      _cityController.text = cityFound;
                      _accountCubit.cityChanged(cityFound);
                      _cityController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _cityController.text.length));
                    }
                    print('State found $cityFound');
                  },

                  //=> _accountCubit.roleChanged(value),
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

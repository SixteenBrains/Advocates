import 'package:advocates/constants/constants.dart';
import 'package:advocates/constants/education_const.dart';

import '/widgets/loading_indicator.dart';
import '/screens/update-account/cubit/update_account_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_account_field.dart';

class EducationInfo extends StatefulWidget {
  final String? level;
  final String? award;
  final String? graduation;
  final String? duration;


  final VoidCallback onSubmit;
  const EducationInfo({
    Key? key,
    required this.level,
    required this.award,
    required this.graduation,
    required this.duration,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<EducationInfo> createState() => _EducationInfoState();
}

class _EducationInfoState extends State<EducationInfo> {

  final _levelController = TextEditingController();
  final _awardController = TextEditingController();
  final _graduationController = TextEditingController();
  final _durationController = TextEditingController();


  @override
  void initState() {
    _levelController.text = widget.level ?? '';
    _awardController.text = widget.award ?? '';
    _graduationController.text = widget.graduation ?? '';
    _durationController.text = widget.duration ?? '';
    super.initState();
  }


  @override
  void dispose() {
    _levelController.dispose();
    _awardController.dispose();
    _graduationController.dispose();
    _durationController.dispose();
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


                UpdateAccountField(
                  controller: _levelController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'LEVEL',
                  onChanged: (value) {
                    final levelFound = level.firstWhere(
                            (element) =>
                            element.toLowerCase().startsWith(value.toLowerCase()),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();
                    if (levelFound.isNotEmpty) {
                      print('Value - $value');
                      print('Region Found $levelFound');
                      _levelController.text = levelFound;
                      _accountCubit.levelChanged(levelFound);
                      _levelController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _levelController.text.length));
                    }
                    print('Gender found $levelFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Level cant\'t be empty');
                      return 'Level cant\'t be empty';
                    }
                    return null;
                  },
                ),


                UpdateAccountField(
                  controller: _awardController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'AWARD',
                  onChanged: (value) {
                    final awardFound = award.firstWhere(
                            (element) =>
                            element.toLowerCase().startsWith(value.toLowerCase()),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();
                    if (awardFound.isNotEmpty) {
                      print('Value - $value');
                      print('Region Found $awardFound');
                      _awardController.text = awardFound;
                      _accountCubit.awardChanged(awardFound);
                      _awardController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _awardController.text.length));
                    }
                    print('Gender found $awardFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Award cant\'t be empty');
                      return 'Award cant\'t be empty';
                    }
                    return null;
                  },
                ),

                UpdateAccountField(
                  controller: _graduationController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'GRADUATION',
                  onChanged: (value) {
                    final graduationFound = graduation.firstWhere(
                            (element) =>
                            element.toLowerCase().startsWith(value.toLowerCase()),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();
                    if (graduationFound.isNotEmpty) {
                      print('Value - $value');
                      print('Region Found $graduationFound');
                      _graduationController.text = graduationFound;
                      _accountCubit.graduationChanged(graduationFound);
                      _graduationController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _graduationController.text.length));
                    }
                    print('Gender found $graduationFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Graduation cant\'t be empty');
                      return 'Graduation cant\'t be empty';
                    }
                    return null;
                  },
                ),

                UpdateAccountField(
                  controller: _durationController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'DURATION',
                  onChanged: (value) {
                    final durationFound = duration.firstWhere(
                            (element) =>
                            element.toLowerCase().startsWith(value.toLowerCase()),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();
                    if (durationFound.isNotEmpty) {
                      print('Value - $value');
                      print('Region Found $durationFound');
                      _durationController.text = durationFound;
                      _accountCubit.durationChanged(durationFound);
                      _durationController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _durationController.text.length));
                    }
                    print('Gender found $durationFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Duration cant\'t be empty');
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

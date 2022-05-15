import '/constants/account_constants.dart';
import '/widgets/loading_indicator.dart';
import '/screens/update-account/cubit/update_account_cubit.dart';
import '/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'update_account_field.dart';

class PersonalInfo extends StatefulWidget {
  final String? age;
  final String? language;
  final String? gender;
  final String? relationship;

  const PersonalInfo(
      {Key? key, this.age, this.language, this.gender, this.relationship})
      : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _languageController = TextEditingController();
  final _relationshipController = TextEditingController();

  @override
  void initState() {
    _ageController.text = widget.age ?? '';
    _languageController.text = widget.language ?? '';
    _relationshipController.text = widget.relationship ?? '';
    _genderController.text = widget.gender ?? '';

    super.initState();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _genderController.dispose();
    _languageController.dispose();
    _relationshipController.dispose();
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
                UpdateAccountField(
                  inputType: TextInputType.number,
                  controller: _ageController,
                  hintText: 'NONE',
                  labelText: 'AGE',
                  onChanged: (value) {
                    final ageFound = age.firstWhere(
                        (element) => element.startsWith(value.toUpperCase()),
                        orElse: () => '');

                    if (ageFound.isNotEmpty) {
                      _ageController.text = ageFound;
                      _accountCubit.ageChanged(ageFound);
                      _ageController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _ageController.text.length));
                    }
                    print('Gender found $ageFound');
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Age cant\'t be empty');
                      return 'Age cant\'t be empty';
                    }
                    return null;
                  },
                ),
                UpdateAccountField(
                  controller: _genderController,
                  hintText: 'NONE',
                  labelText: 'GENDER',
                  onChanged: (value) {
                    final genderFound = gender.firstWhere(
                        (element) => element.startsWith(value.toUpperCase()),
                        orElse: () => '');

                    if (genderFound.isNotEmpty) {
                      _genderController.text = genderFound;
                      _accountCubit.genderChanged(genderFound);
                      _genderController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _genderController.text.length));
                    }
                    print('Gender found $genderFound');
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Gender cant\'t be empty');
                      return 'Gender cant\'t be empty';
                    }
                    return null;
                  },
                ),

                //language
                UpdateAccountField(
                  controller: _languageController,
                  hintText: 'NONE',
                  labelText: 'LANGUAGE',
                  onChanged: (value) {
                    final languageFound = languages.firstWhere(
                        (element) => element.startsWith(value.toUpperCase()),
                        orElse: () => '');

                    if (languageFound.isNotEmpty) {
                      _languageController.text = languageFound;
                      _accountCubit.languageChanged(languageFound);
                      _languageController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _languageController.text.length));
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit
                          .addErrorMessage('Language cant\'t be empty');
                      return 'Language cant\'t be empty';
                    }
                    return null;
                  },
                ),
                // realtionship

                UpdateAccountField(
                  controller: _relationshipController,
                  hintText: 'NONE',
                  labelText: 'RELATIONSHIP',
                  onChanged: (value) {
                    final relationship = relationShipStatus.firstWhere(
                        (element) => element.startsWith(value.toUpperCase()),
                        orElse: () => '');

                    if (relationship.isNotEmpty) {
                      _relationshipController.text = relationship;
                      _accountCubit.relationshipChanged(relationship);
                      _relationshipController.selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _relationshipController.text.length));
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit
                          .addErrorMessage('Relationship cant\'t be empty');
                      return 'Relationship cant\'t be empty';
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

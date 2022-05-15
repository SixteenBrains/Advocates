import '/constants/account_constants.dart';
import '/screens/update-account/widgets/update_account_field.dart';

import '/screens/update-account/cubit/update_account_cubit.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/custom_textfield.dart';
import '/blocs/auth/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalInfo extends StatefulWidget {
  final String? role;
  final String? title;
  final String? industry;
  final String? skill;
  final String? sector;

  const ProfessionalInfo({Key? key,required  this.role,required  this.title,required this.industry,required  this.skill, required this.sector,}) : super(key: key);

  @override
  State<ProfessionalInfo> createState() => _ProfessionalInfoState();
}

class _ProfessionalInfoState extends State<ProfessionalInfo> {
  final _roleController = TextEditingController();
  final _titleController = TextEditingController();
  final _industryController = TextEditingController();
  final _skillController = TextEditingController();
  final _sectorController =TextEditingController();

  @override
  void dispose() {
    _roleController.dispose();
    _titleController.dispose();
    _industryController.dispose();
    _skillController.dispose();
    super.dispose();
  }

    @override
  void initState() {
    _roleController.text = widget.role ?? '';
    _titleController.text = widget.title ?? '';
    _industryController.text = widget.industry ?? '';
    _skillController.text = widget.skill ?? '';
    _sectorController.text = widget.sector ?? '';

    super.initState();
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
                UpdateAccountField(
                  controller: _roleController,
                 // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'ROLE',
                  onChanged: (value) {
                    final roleFound = industry.firstWhere(
                            (element) =>
                            element.contains(value),
                        // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();

                    // final roleFound = role.firstWhere(
                    //         (element) => element.startsWith(value.toUpperCase()),
                    //     orElse: () => '');

                    if (roleFound.isNotEmpty) {
                      _roleController.text = roleFound;
                      _roleController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _roleController.text.length));
                    }
                    print('Gender found $roleFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Age cant\'t be empty');
                      return 'Role cant\'t be empty';
                    }
                    return null;
                  },
                ),

                UpdateAccountField(
                  controller: _industryController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'INDUSTRY',
                  onChanged: (value) {
                    final industryFound = industry.firstWhere(
                            (element) =>
                                element.contains(value),
                                // element.startsWith(value.toUpperCase()),
                        orElse: () => '').toUpperCase();

                    if (industryFound.isNotEmpty) {
                      _industryController.text = industryFound;
                      _accountCubit.industryChanged(industryFound);
                      _industryController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _industryController.text.length));
                    }
                    print('Industry found $industryFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Industry cant\'t be empty');
                      return 'Industry cant\'t be empty';
                    }
                    return null;
                  },
                ),


                UpdateAccountField(
                  controller: _sectorController,
                  // initialValue: state.role,
                  hintText: 'NONE',
                  labelText: 'SECTOR',
                  onChanged: (value) {
                    final sectorFound = sector.firstWhere(
                            (element) =>
                            element.contains(value.toUpperCase()),


                               // element.startsWith (value.toUpperCase()),
                        orElse: () => '');

                    if (sectorFound.isNotEmpty) {
                      _sectorController.text = sectorFound;
                      _accountCubit.sectorChanged(sectorFound);
                      _sectorController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _sectorController.text.length));
                    }
                    print('Industry found $sectorFound');
                  },

                  //=> _accountCubit.roleChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      _accountCubit.addErrorMessage('Sector cant\'t be empty');
                      return 'Sector cant\'t be empty';
                    }
                    return null;
                  },
                ),



                // const SizedBox(height: 25.0),

              ],
            ),
          ),
        );
      },
    );
  }
}

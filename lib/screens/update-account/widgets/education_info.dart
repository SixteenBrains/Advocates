import '/widgets/loading_indicator.dart';
import '/screens/update-account/cubit/update_account_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EducationInfo extends StatefulWidget {
  const EducationInfo({Key? key}) : super(key: key);

  @override
  State<EducationInfo> createState() => _EducationInfoState();
}

class _EducationInfoState extends State<EducationInfo> {
  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // TODO add validation to all the pages
      context.read<UpdateAccountCubit>().submitDetails();
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _authBloc = context.read<AuthBloc>();
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
            child: Form(
              key: _formKey,
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
                    initialValue: state.lavel,
                    hintText: 'NONE',
                    labelText: 'LEVEL',
                    onChanged: (value) =>
                        context.read<UpdateAccountCubit>().levelChanged(value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Level cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 25.0),
                  CustomTextField(
                    initialValue: state.award,
                    hintText: 'NONE',
                    labelText: 'AWARD',
                    onChanged: (value) =>
                        context.read<UpdateAccountCubit>().awardChanged(value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Award cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  //  const SizedBox(height: 25.0),
                  CustomTextField(
                    initialValue: state.graduation,
                    hintText: 'NONE',
                    labelText: 'GRADUATION',
                    onChanged: (value) => context
                        .read<UpdateAccountCubit>()
                        .graduationChanged(value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Graduation cant\'t be empty';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    initialValue: state.graduation,
                    hintText: 'NONE',
                    labelText: 'DURATION',
                    onChanged: (value) => context
                        .read<UpdateAccountCubit>()
                        .durationChanged(value),
                    validator: (value) {
                      if (value!.isEmpty) {
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
                      onPressed: () => _submit(context),
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
          ),
        );
      },
    );
  }
}

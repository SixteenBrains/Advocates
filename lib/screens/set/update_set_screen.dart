import '/enums/enums.dart';
import '/screens/set/widgets/update_ad_media.dart';
import 'package:enum_to_string/enum_to_string.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/set/set_repository.dart';
import '/models/set_model.dart';
import '/widgets/custom_textfield.dart';
import '/screens/nav/bloc/nav_bloc.dart';
import '/constants/constants.dart';
import '/widgets/custom_dropdown.dart';
import '/screens/set/cubit/set_cubit.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/ad_media.dart';

class UpDateSetArgs {
  final SetModel? setModel;

  const UpDateSetArgs({required this.setModel});
}

class UpdateSetScreen extends StatefulWidget {
  static const String routeName = '/updateSet';
  final SetModel? setModel;
  const UpdateSetScreen({Key? key, required this.setModel}) : super(key: key);

  static Route route({required UpDateSetArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<SetCubit>(
        create: (context) => SetCubit(
          setRepository: context.read<SetRepository>(),
          authBloc: context.read<AuthBloc>(),
        ),
        child: UpdateSetScreen(setModel: args.setModel),
      ),
    );
  }

  @override
  State<UpdateSetScreen> createState() => _UpdateSetScreenState();
}

class _UpdateSetScreenState extends State<UpdateSetScreen> {
  final _formKey = GlobalKey<FormState>();

  void submit() {
    if (_formKey.currentState!.validate()) {
      //context.read<SetCubit>().uploadSet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'SET MANAGER',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<SetCubit, SetState>(
        listener: (context, state) {
          if (state.status == SetStatus.succuss) {
            context
                .read<NavBloc>()
                .add(const UpdateNavItem(item: NavItem.dashboard));
          }
          if (widget.setModel?.subsets != null) {
            final subSets = widget.setModel?.subsets ?? [];
            for (var item in subSets) {
              if (item != null) {
                print('Subset $item');
                context.read<SetCubit>().addSubSet(item);
              }
            }
          }
        },
        builder: (context, state) {
          if (state.status == SetStatus.loading) {
            return const LoadingIndicator();
          }
          final subSets = widget.setModel?.subsets ?? [];
          print('Set from navigation ${widget.setModel}');
          print(
              'Formate from navigation ${EnumToString.convertToString(widget.setModel?.mediaFormat).toUpperCase()}');
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30.0),
                    Center(
                      child: Image.asset(
                        'assets/images/set_manager.png',
                        height: 64.0,
                        width: 64.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'SET MANAGER',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'SETS represent some of the most pressing issues in\nthe world. You can create 1 with up to 6 SUBSETS.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // const SizedBox(height: 25.0),
                    const SizedBox(height: 25.0),
                    CustomTextField(
                      initialValue: widget.setModel?.name,
                      hintText: 'NONE',
                      labelText: 'NAME',
                      onChanged: (value) =>
                          context.read<SetCubit>().nameChanged(value),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    // const SizedBox(height: 25.0),

                    CustomDropDown(
                      labelText: 'CAUSES',
                      dropDownOptions: causes,
                      onChanged: (value) =>
                          context.read<SetCubit>().causeChanged(value),
                      selectedValue: widget.setModel?.cause ?? state.cause,
                    ),
                    // const SizedBox(height: 25.0),
                    CustomDropDown(
                      labelText: 'FORMAT',
                      dropDownOptions: formate,
                      onChanged: (value) =>
                          context.read<SetCubit>().changeFormat(value),
                      selectedValue: widget.setModel?.mediaFormat != null
                          ? EnumToString.convertToString(
                                  widget.setModel?.mediaFormat)
                              .toUpperCase()
                          : state.format.toString().toUpperCase(),
                    ),

                    const SizedBox(height: 20.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < 6; i++)
                          subSets.length > i
                              ? UpdateAdMedia(
                                  onTap: () {},
                                  mediaFormat: MediaFormat.images,
                                  imageUrl: subSets[i]?.imageUrl,
                                )
                              : AdMedia(
                                  onTap: () {},
                                  fileType: MediaFormat.images,
                                  //state.fileType,
                                  imageFile: null,
                                )

                        // for (int i = 0; i < 6; i++)
                        //   AdMedia(
                        //     imageFile: state.subSets.length > i
                        //         ? state.subSets[i]?.imageFile
                        //         : null,
                        //     fileType: state.fileType,
                        //     //  imageFile: null,
                        //     onTap: () async {
                        //       print('Cause ${state.cause}');
                        //       print('Title ${state.name}');
                        //       print('Format ${state.format}');

                        //       if (state.name != null) {
                        //         final subSet =
                        //             await Navigator.of(context).pushNamed(
                        //           AddSubset.routeName,
                        //           arguments: AddSubSetArgs(
                        //             setModel: SetModel(
                        //               cause: state.cause,
                        //               format: state.fileType,
                        //               name: state.name,
                        //               author:
                        //                   context.read<AuthBloc>().state.user,
                        //             ),
                        //           ),
                        //         ) as SubSet?;
                        //         print('Subset - $subSet');

                        //         if (subSet != null) {
                        //           context.read<SetCubit>().addSubSet(subSet);
                        //         }
                        //       } else {
                        //         ShowSnackBar.showSnackBar(context,
                        //             title:
                        //                 'Complete the set fields to continue');
                        //       }
                        //     },
                        //   )
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Your SET NAME must be less than 16 characters and\nyou need at least 1 SUBSET before a SET can be created.',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.0,
                          color: Colors.grey.shade500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import '/widgets/custom_textfield.dart';
import '/models/sub_set.dart';
import '/repositories/set/set_repository.dart';
import '/screens/set/cubit/set_cubit.dart';
import '/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSubset extends StatefulWidget {
  static const String routeName = '/add';
  const AddSubset({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => SetCubit(
          setRepository: context.read<SetRepository>(),
        ),
        child: const AddSubset(),
      ),
    );
  }

  @override
  State<AddSubset> createState() => _AddSubsetState();
}

class _AddSubsetState extends State<AddSubset> {
  final _formKey = GlobalKey<FormState>();

  void submit() {
    if (_formKey.currentState!.validate()) {
      final _setCubit = context.read<SetCubit>();
      if (_setCubit.state.pickedFile != null) {
        final subSet = SubSet(
          title: _setCubit.state.subSetTitle,
          destination: _setCubit.state.subSetDestination,
          description: _setCubit.state.subSetdescription,
          imageFile: _setCubit.state.pickedFile,
        );
        Navigator.of(context).pop(subSet);
      } else {
        ShowSnackBar.showSnackBar(context,
            title: 'Please select image to continue');
      }
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
          'SUBSET',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: BlocConsumer<SetCubit, SetState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 15.0,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Center(
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              context.read<SetCubit>().pickedFileChanged(),
                          child: state.pickedFile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.file(
                                    state.pickedFile!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  'assets/images/menu_upload.png',
                                  height: 15.0,
                                  width: 15.0,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'ADD A SUBSET',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'SUBSETS are SETS that can be added to another\nSET and you need at least 1 SUBSET in a SET.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      initialValue: '',
                      labelText: 'Title',
                      hintText: 'NONE',
                      onChanged: (value) =>
                          context.read<SetCubit>().subSetTitleChanged(value),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Title can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      initialValue: '',
                      labelText: 'DESTINATION',
                      hintText: 'NONE',
                      onChanged: (value) => context
                          .read<SetCubit>()
                          .subSetDestinationChanged(value),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Destination can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      initialValue: '',
                      minLines: 3,
                      labelText: 'DESCRIPTION',
                      hintText: 'NONE',
                      onChanged: (value) => context
                          .read<SetCubit>()
                          .subSetDescriptionChanged(value),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      height: 52.0,
                      width: 200.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2ED573),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                        onPressed: submit,
                        child: const Text(
                          'DONE',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
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
      ),
    );
  }
}
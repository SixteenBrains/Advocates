import '/enums/enums.dart';
import 'package:enum_to_string/enum_to_string.dart';
import '/widgets/loading_indicator.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/profile/profile_repository.dart';
import '/screens/account/cubit/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormateScreen extends StatelessWidget {
  static const String routeName = '/formate';
  const FormateScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => AccountCubit(
          profileRepository: context.read<ProfileRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..getSelectedMedia(),
        child: const FormateScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
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
        title: const Text(
          'FORMAT',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == AccountStatus.loading) {
            return const LoadingIndicator();
          }
          print('Format ${state.format}');
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                Center(
                  child: Image.asset(
                    'assets/images/preference_format.png',
                    height: 64.0,
                    width: 64.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'FORMATE',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Kindly select the type of SETS that you\'d\nlike to be shown in the search results.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: MediaType.values.length,
                    //   formateAvailable.length,
                    itemBuilder: (context, index) {
                      final format =
                          EnumToString.convertToString(MediaType.values[index])
                              .toUpperCase();
                      // formateAvailable[index];

                      final isSelected =
                          state.format == MediaType.values[index];

                      print('Is selected $isSelected');
                      final enumValue =
                          EnumToString.fromString(MediaType.values, format) ??
                              MediaType.images;
                      return ChooseMediaFormate(
                        isSelected: isSelected,
                        label: format.toString(),
                        onTap: () => context
                            .read<AccountCubit>()
                            .addMediaFormat(enumValue),
                      );
                    },
                  ),
                ),
                // ChooseMediaFormate(
                //   bgColor: Colors.white,
                //   textColor: Colors.black,
                //   label: 'GIFs',
                //   onTap: () => context
                //       .read<AccountCubit>()
                //       .addMediaFormat(FileType.image),
                // ),
                // const SizedBox(height: 10.0),
                // ChooseMediaFormate(
                //   bgColor: Colors.white,
                //   textColor: Colors.black,
                //   label: 'IMAGES',
                //   onTap: () => context
                //       .read<AccountCubit>()
                //       .addMediaFormat(FileType.image),
                // ),
                // const SizedBox(height: 10.0),
                // ChooseMediaFormate(
                //   bgColor: Colors.white,
                //   textColor: Colors.black,
                //   label: 'VIDEOS',
                //   onTap: () => context
                //       .read<AccountCubit>()
                //       .addMediaFormat(FileType.video),
                // ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ChooseMediaFormate extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const ChooseMediaFormate({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

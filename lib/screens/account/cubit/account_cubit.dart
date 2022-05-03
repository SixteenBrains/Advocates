import 'package:advocates/blocs/auth/auth_bloc.dart';
import 'package:advocates/repositories/profile/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final ProfileRepository _profileRepository;
  final AuthBloc _authBloc;
  AccountCubit({
    required ProfileRepository profileRepository,
    required AuthBloc authBloc,
  })  : _profileRepository = profileRepository,
        _authBloc = authBloc,
        super(AccountState.initial());

  void addMediaFormat(FileType type) async {
    // emit(state.copyWith());
    await _profileRepository.addMediaFormat(
        userId: _authBloc.state.user?.uid, format: type);
  }
}

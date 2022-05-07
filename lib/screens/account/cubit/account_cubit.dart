import '/repositories/account/account_repository.dart';
import '/enums/enums.dart';
import 'package:enum_to_string/enum_to_string.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/failure.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository _profileRepository;
  final AuthBloc _authBloc;

  AccountCubit({
    required AccountRepository accountRepository,
    required AuthBloc authBloc,
  })  : _profileRepository = accountRepository,
        _authBloc = authBloc,
        super(AccountState.initial());

  // cause

  void addCause(String cause) {
    try {
      //emit(state.copyWith(status: AccountStatus.loading));
      final List<String> causes = List.from(state.causes)..add(cause);
      emit(state.copyWith(causes: causes));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AccountStatus.error));
    }
  }

  void submitCause() async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      await _profileRepository.uploadCauses(
          userId: _authBloc.state.user?.uid, causes: state.causes);
      emit(state.copyWith(status: AccountStatus.submitted));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AccountStatus.error));
    }
  }

  void removeCause(String cause) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      final List<String> causes = List.from(state.causes)..remove(cause);
      emit(state.copyWith(causes: causes, status: AccountStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AccountStatus.error));
    }
  }

  void loadSelectedCauses() async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      final causes = await _profileRepository.getSelectedCauses(
          userId: _authBloc.state.user?.uid);
      emit(state.copyWith(causes: causes, status: AccountStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AccountStatus.error));
    }
  }

  // format

  void addMediaFormat(MediaFormat format) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));

      await _profileRepository.addMediaFormat(
          userId: _authBloc.state.user?.uid, mediaType: format);
      emit(state.copyWith(status: AccountStatus.submitted, format: format));
    } on Failure catch (failure) {
      emit(state.copyWith(status: AccountStatus.error, failure: failure));
    }
  }

  void getSelectedMedia() async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));
      final format = await _profileRepository.getSelectedMediaFormat(
          userId: _authBloc.state.user?.uid);
      emit(state.copyWith(
          status: AccountStatus.succuss,
          format:
              EnumToString.fromString(MediaFormat.values, format ?? 'IMAGES')));
    } on Failure catch (failure) {
      emit(state.copyWith(status: AccountStatus.error, failure: failure));
    }
  }

  void getAdvocatesCount() async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));

      final count = await _profileRepository.getAdvocatesCount(
          userId: _authBloc.state.user?.uid);
      emit(
          state.copyWith(advocatesCount: count, status: AccountStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: AccountStatus.error));
    }
  }
}

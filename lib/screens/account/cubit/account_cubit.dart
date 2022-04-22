import 'package:advocates/models/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState.initial());

  void genderChanged(String? value) async {
    emit(state.copyWith(selectedGender: value, status: AccountStatus.initial));
  }

  void languageChanged(String? value) {
    emit(
        state.copyWith(selectedLanguage: value, status: AccountStatus.initial));
  }

  void relationShipStatusChanged(String? value) {
    emit(state.copyWith(
        relationShipStatus: value, status: AccountStatus.initial));
  }

  void ageChanged(String value) {
    emit(state.copyWith(age: value, status: AccountStatus.initial));
  }
}

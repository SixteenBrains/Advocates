import '/repositories/account/account_repository.dart';

import '/blocs/auth/auth_bloc.dart';
import '/models/education.dart';
import '/models/location.dart';
import '/models/personal.dart';
import '/models/professsion.dart';
import '/models/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_account_state.dart';

class UpdateAccountCubit extends Cubit<UpdateAccountState> {
  final AccountRepository _profileRepository;
  final AuthBloc _authBloc;
  UpdateAccountCubit({
    required AccountRepository profileRepository,
    required AuthBloc authBloc,
  })  : _profileRepository = profileRepository,
        _authBloc = authBloc,
        super(UpdateAccountState.initial());

  // personal fields

  void ageChanged(String? value) {
    emit(state.copyWith(age: value, status: UpdateAccountStatus.initial));
  }

  void genderChanged(String? value) {
    emit(state.copyWith(gender: value, status: UpdateAccountStatus.initial));
  }

  void languageChanged(String? value) {
    emit(state.copyWith(language: value, status: UpdateAccountStatus.initial));
  }

  void relationshipChanged(String? value) {
    emit(state.copyWith(
        relationship: value, status: UpdateAccountStatus.initial));
  }

  // profession fields
  void roleChanged(String? value) {
    emit(state.copyWith(role: value, status: UpdateAccountStatus.initial));
  }

  void titleChanged(String? value) {
    emit(state.copyWith(title: value, status: UpdateAccountStatus.initial));
  }

  void industryChanged(String value) {
    emit(state.copyWith(industry: value, status: UpdateAccountStatus.initial));
  }

  void skillChanged(String? value) {
    emit(state.copyWith(skill: value, status: UpdateAccountStatus.initial));
  }

  // location fields
  void regionChanged(String? value) {
    emit(state.copyWith(region: value, status: UpdateAccountStatus.initial));
  }

  void countryChanged(String? value) {
    emit(state.copyWith(country: value, status: UpdateAccountStatus.initial));
  }

  void stateChanged(String? value) {
    emit(state.copyWith(state: value, status: UpdateAccountStatus.initial));
  }

  void cityChanged(String? value) {
    emit(state.copyWith(city: value, status: UpdateAccountStatus.initial));
  }

  // Education fields
  void levelChanged(String? value) {
    emit(state.copyWith(lavel: value, status: UpdateAccountStatus.initial));
  }

  void awardChanged(String? value) {
    emit(state.copyWith(award: value, status: UpdateAccountStatus.initial));
  }

  void graduationChanged(String? value) {
    emit(
        state.copyWith(graduation: value, status: UpdateAccountStatus.initial));
  }

  void durationChanged(String? value) {
    emit(state.copyWith(duration: value, status: UpdateAccountStatus.initial));
  }

  void addErrorMessage(String error) async {
    emit(state.copyWith(errorMsg: error, status: UpdateAccountStatus.error));
  }

  void loadAccountDetails() async {
    try {
      emit(state.copyWith(status: UpdateAccountStatus.loading));

      final user =
          await _profileRepository.getUserData(_authBloc.state.user?.uid);

      emit(state.copyWith(
        status: UpdateAccountStatus.succuss,
        age: user?.personal?.age,
        gender: user?.personal?.gender,
        language: user?.personal?.language,
        relationship: user?.personal?.relationship,
        role: user?.profession?.role,
        title: user?.profession?.title,
        industry: user?.profession?.industry,
        skill: user?.profession?.skill,
        region: user?.location?.region,
        country: user?.location?.country,
        state: user?.location?.state,
        city: user?.location?.city,
        lavel: user?.education?.lavel,
        award: user?.education?.award,
        graduation: user?.education?.graduation,
        duration: user?.education?.duration,
      ));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: UpdateAccountStatus.error));
    }
  }

  void submitDetails() async {
    try {
      emit(state.copyWith(status: UpdateAccountStatus.loading));

      final personal = Personal(
        age: state.age,
        gender: state.gender,
        language: state.language,
        relationship: state.relationship,
      );

      final education = Education(
        lavel: state.lavel,
        award: state.award,
        graduation: state.graduation,
        duration: state.graduation,
      );

      final location = Location(
        region: state.region,
        country: state.country,
        state: state.state,
        city: state.city,
      );

      final profession = Profession(
        role: state.role,
        title: state.title,
        industry: state.industry,
        skill: state.skill,
      );

      final user = _authBloc.state.user?.copyWith(
        personal: personal,
        profession: profession,
        location: location,
        education: education,
        // createdAt: DateTime.now()
      );

      await _profileRepository.updateAccount(user);

      emit(state.copyWith(status: UpdateAccountStatus.succuss));
      print('level ${state.lavel}');
    } on Failure catch (failure) {
      emit(state.copyWith(status: UpdateAccountStatus.error, failure: failure));
    }
  }
}

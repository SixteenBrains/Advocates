part of 'update_account_cubit.dart';

enum UpdateAccountStatus { initial, loading, succuss, error }

class UpdateAccountState extends Equatable {
  final String? age;
  final String? gender;
  final String? language;
  final String? relationship;
  final String? role;
  final String? title;
  final String? industry;
  final String? skill;
  final String? region;
  final String? country;
  final String? state;
  final String? city;
  final String? lavel;
  final String? award;
  final String? graduation;
  final String? duration;
  final String? sector;
  final UpdateAccountStatus status;
  final Failure failure;

  final String? errorMsg;
  const UpdateAccountState(
      {this.age,
      this.gender,
      this.language,
      this.relationship,
      this.role,
      this.title,
      this.industry,
      this.skill,
      this.region,
      this.country,
      this.state,
      this.city,
      this.lavel,
      this.award,
      this.graduation,
        this.sector,
      this.duration,
      required this.status,
      required this.failure,

      this.errorMsg = 'Something went wrong'});

  factory UpdateAccountState.initial() => const UpdateAccountState(
      status: UpdateAccountStatus.initial, failure: Failure(), );

  UpdateAccountState copyWith({
    String? age,
    String? gender,
    String? language,
    String? relationship,
    String? role,
    String? title,
    String? industry,
    String? skill,
    String? region,
    String? country,
    String? state,
    String? city,
    String? lavel,
    String? award,
    String? graduation,
    String? duration,
    UpdateAccountStatus? status,
    Failure? failure,
    String? errorMsg,
    String? sector,
  }) {
    return UpdateAccountState(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      language: language ?? this.language,
      relationship: relationship ?? this.relationship,
      role: role ?? this.role,
      title: title ?? this.title,
      industry: industry ?? this.industry,
      skill: skill ?? this.skill,
      region: region ?? this.region,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      lavel: lavel ?? this.lavel,
      award: award ?? this.award,
      graduation: graduation ?? this.graduation,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      errorMsg: errorMsg ?? this.errorMsg,
      sector: sector?? this.sector,
    );
  }

  @override
  String toString() {
    return 'UpdateAccountState(age: $age, gender: $gender, language: $language, relationship: $relationship, role: $role, title: $title, industry: $industry, skill: $skill, region: $region, country: $country, state: $state, city: $city, lavel: $lavel, award: $award, graduation: $graduation, duration: $duration, status: $status, failure: $failure, errorMsg $errorMsg, sector: $sector,)';
  }

  @override
  List<Object?> get props {
    return [
      age,
      gender,
      language,
      relationship,
      role,
      title,
      industry,
      skill,
      region,
      country,
      state,
      city,
      lavel,
      award,
      graduation,
      duration,
      status,
      failure,
      errorMsg,
      sector,
    ];
  }
}

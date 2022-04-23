part of 'account_cubit.dart';

enum AccountStatus { initial, loading, succuss, error }

class AccountState extends Equatable {
  final String? selectedGender;
  final String? selectedLanguage;
  final String? relationShipStatus;
  final Failure failure;
  final String? age;

  final AccountStatus status;
  const AccountState({
    this.selectedGender,
    this.selectedLanguage,
    this.relationShipStatus,
    required this.failure,
    required this.status,
    this.age,
  });

  AccountState copyWith({
    String? selectedGender,
    String? selectedLanguage,
    String? relationShipStatus,
    Failure? failure,
    AccountStatus? status,
    String? age,
  }) {
    return AccountState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      relationShipStatus: relationShipStatus ?? this.relationShipStatus,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      age: age ?? this.age,
    );
  }

  factory AccountState.initial() => const AccountState(
        failure: Failure(),
        status: AccountStatus.initial,
        selectedGender: 'MALE',
        selectedLanguage: 'ENGLISH',
        relationShipStatus: 'SINGLE',
        age: null,
      );

  @override
  String toString() {
    return 'AccountState(selectedGender: $selectedGender, selectedLanguage: $selectedLanguage, relationShipStatus: $relationShipStatus, failure: $failure, status: $status, age: $age)';
  }

  @override
  List<Object?> get props {
    return [
      selectedGender,
      selectedLanguage,
      relationShipStatus,
      failure,
      status,
      age,
    ];
  }
}

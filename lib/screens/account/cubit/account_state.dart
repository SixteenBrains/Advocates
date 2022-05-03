part of 'account_cubit.dart';

class AccountState extends Equatable {
  final FileType? fileType;
  final List<String?> causes;

  const AccountState({
    this.fileType,
    required this.causes,
  });

  @override
  List<Object?> get props => [fileType, causes];

  AccountState copyWith({
    FileType? fileType,
    List<String?>? causes,
  }) {
    return AccountState(
      fileType: fileType ?? this.fileType,
      causes: causes ?? this.causes,
    );
  }

  factory AccountState.initial() =>
      const AccountState(causes: [], fileType: FileType.image);

  @override
  String toString() => 'AccountState(fileType: $fileType, causes: $causes)';
}

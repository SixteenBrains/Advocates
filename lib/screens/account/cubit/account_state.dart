part of 'account_cubit.dart';

enum AccountStatus { initial, loading, succuss, submitted, error }

class AccountState extends Equatable {
  final FileType? fileType;
  //final String? format;
  final MediaType? format;
  final List<String?> causes;
  final AccountStatus status;
  final Failure failure;

  const AccountState({
    this.fileType,
    required this.causes,
    required this.format,
    required this.status,
    required this.failure,
  });

  @override
  List<Object?> get props => [fileType, causes, format, status, failure];

  AccountState copyWith({
    FileType? fileType,
    List<String?>? causes,
    MediaType? format,
    Failure? failure,
    AccountStatus? status,
  }) {
    return AccountState(
      fileType: fileType ?? this.fileType,
      causes: causes ?? this.causes,
      format: format ?? this.format,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  factory AccountState.initial() => const AccountState(
        causes: [],
        fileType: FileType.image,
        // format: 'IMAGES',
        format: MediaType.images,
        failure: Failure(),
        status: AccountStatus.initial,
      );

  @override
  String toString() =>
      'AccountState(fileType: $fileType, causes: $causes, format: $format, status: $status, failure: $failure )';
}

part of 'account_cubit.dart';

enum AccountStatus { initial, loading, succuss, submitted, error }

class AccountState extends Equatable {
  final FileType? fileType;
  //final String? format;
  final MediaFormat? format;
  final List<String?> causes;
  final AccountStatus status;
  final Failure failure;
  final int advocatesCount;

  const AccountState({
    this.fileType,
    required this.causes,
    required this.format,
    required this.status,
    required this.failure,
    this.advocatesCount = 0,
  });

  @override
  List<Object?> get props =>
      [fileType, causes, format, status, failure, advocatesCount];

  AccountState copyWith({
    FileType? fileType,
    List<String?>? causes,
    MediaFormat? format,
    Failure? failure,
    AccountStatus? status,
    int? advocatesCount,
  }) {
    return AccountState(
      fileType: fileType ?? this.fileType,
      causes: causes ?? this.causes,
      format: format ?? this.format,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      advocatesCount: advocatesCount ?? this.advocatesCount,
    );
  }

  factory AccountState.initial() => const AccountState(
        causes: [],
        fileType: FileType.image,
        // format: 'IMAGES',
        format: MediaFormat.images,
        failure: Failure(),
        status: AccountStatus.initial,
        advocatesCount: 0,
      );

  @override
  String toString() =>
      'AccountState(fileType: $fileType, causes: $causes, format: $format, status: $status, failure: $failure, advocatesCount $advocatesCount )';
}

part of 'set_cubit.dart';

enum SetStatus { initial, loading, succuss, error }

class SetState extends Equatable {
  // final List<File?> pickedFiles;
  final List<SubSet?> subSets;
  final Failure failure;
  final SetStatus status;
  final String? name;
  final String? cause;
  final MediaFormat mediaFormat;
  final String? format;
  final File? pickedFile;
  final String? subSetTitle;
  final String? subSetDestination;
  final String? subSetdescription;
  final List<SetModel?> sets;

  const SetState({
    this.subSets = const [],
    required this.failure,
    required this.status,
    this.name,
    this.cause,
    this.format,
    this.mediaFormat = MediaFormat.images,
    this.pickedFile,
    this.subSetdescription,
    this.subSetDestination,
    this.subSetTitle,
    this.sets = const [],
  });

  factory SetState.initial() => const SetState(
        subSets: [],
        cause: 'ABUSE',
        name: null,
        failure: Failure(),
        status: SetStatus.initial,
        format: 'IMAGES',
        mediaFormat: MediaFormat.images,
        pickedFile: null,
        subSetdescription: null,
        subSetDestination: null,
        subSetTitle: null,
        sets: [],
      );

  @override
  List<Object?> get props => [
        subSets,
        failure,
        status,
        name,
        cause,
        format,
        pickedFile,
        subSetdescription,
        subSetDestination,
        subSetTitle,
        mediaFormat,
        sets,
      ];

  SetState copyWith({
    List<SubSet?>? subSets,
    Failure? failure,
    SetStatus? status,
    String? name,
    String? cause,
    String? format,
    File? pickedFile,
    String? subSetTitle,
    String? subSetDestination,
    String? subSetdescription,
    MediaFormat? mediaFormat,
    List<SetModel?>? sets,
  }) {
    return SetState(
      subSets: subSets ?? this.subSets,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      name: name ?? this.name,
      cause: cause ?? this.cause,
      mediaFormat: mediaFormat ?? this.mediaFormat,
      format: format ?? this.format,
      pickedFile: pickedFile ?? this.pickedFile,
      subSetTitle: subSetTitle ?? this.subSetTitle,
      subSetDestination: subSetDestination ?? this.subSetDestination,
      subSetdescription: subSetdescription ?? this.subSetdescription,
      sets: sets ?? this.sets,
    );
  }

  @override
  String toString() {
    return 'SetState(subSets: $subSets, failure: $failure, status: $status, name: $name, causes: $cause, format: $format, pickedFile: $pickedFile, subSetName: $subSetTitle, subSetDestination: $subSetDestination, subSetdescription: $subSetdescription, mediaFormat: $mediaFormat, sets: $sets)';
  }
}

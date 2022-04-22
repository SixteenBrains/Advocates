import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import 'package:advocates/models/sub_set.dart';
import 'package:file_picker/file_picker.dart';

class SetModel extends Equatable {
  final String? name;
  final String? cause;
  final FileType? format;
  final List<SubSet?> subsets;

  const SetModel({
    this.name,
    this.cause,
    this.format,
    required this.subsets,
  });

  SetModel copyWith({
    String? name,
    String? cause,
    FileType? format,
    List<SubSet?>? subsets,
  }) {
    return SetModel(
      name: name ?? this.name,
      cause: cause ?? this.cause,
      format: format ?? this.format,
      subsets: subsets ?? this.subsets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cause': cause,
      'format': EnumToString.convertToString(format),
      'subsets': subsets.map((x) => x?.toMap()).toList(),
    };
  }

  factory SetModel.fromMap(Map<String, dynamic> map) {
    return SetModel(
      name: map['name'],
      cause: map['cause'],
      format: EnumToString.fromString(FileType.values, map['format']),
      subsets: map['subsets'] != null
          ? List<SubSet?>.from(map['subsets']?.map((x) => SubSet.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory SetModel.fromJson(String source) =>
      SetModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Set(name: $name, cause: $cause, format: $format, subsets: $subsets)';
  }

  @override
  List<Object?> get props => [name, cause, format, subsets];
}

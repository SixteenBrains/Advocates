import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class Preferences extends Equatable {
  final FileType? format;
  final List<String?> causes;

  const Preferences({
    this.format,
    required this.causes,
  });

  Preferences copyWith({
    FileType? format,
    List<String?>? causes,
  }) {
    return Preferences(
      format: format ?? this.format,
      causes: causes ?? this.causes,
    );
  }

  @override
  String toString() => 'Preferences(formate: $format, causes: $causes)';

  @override
  List<Object?> get props => [format, causes];

  Map<String, dynamic> toMap() {
    return {
      'format': format,
      'causes': causes,
    };
  }

  factory Preferences.fromMap(Map<String, dynamic> map) {
    return Preferences(
      format: EnumToString.fromString(FileType.values, map['format']),
      causes: List<String?>.from(map['causes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Preferences.fromJson(String source) =>
      Preferences.fromMap(json.decode(source));
}

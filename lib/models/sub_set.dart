import 'dart:convert';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class SubSet extends Equatable {
  final String? subSetId;
  final String? title;
  final String? destination;
  final String? description;
  final String? imageUrl;
  final File? imageFile;
  final String? cause;
  final FileType? format;

  const SubSet({
    this.subSetId,
    this.title,
    this.destination,
    this.description,
    this.imageUrl,
    this.imageFile,
    required this.cause,
    required this.format,
  });

  SubSet copyWith({
    String? subSetId,
    String? title,
    String? destination,
    String? description,
    String? imageUrl,
    File? imageFile,
    String? cause,
    FileType? format,
  }) {
    return SubSet(
      subSetId: subSetId ?? this.subSetId,
      title: title ?? this.title,
      destination: destination ?? this.destination,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile ?? this.imageFile,
      cause: cause ?? this.cause,
      format: format ?? this.format,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subSetId': subSetId,
      'title': title,
      'destination': destination,
      'description': description,
      'imageUrl': imageUrl,
      'cause': cause,
      'format': EnumToString.convertToString(format),
    };
  }

  factory SubSet.fromMap(Map<String, dynamic> map) {
    return SubSet(
      subSetId: map['subSetId'],
      title: map['title'],
      destination: map['destination'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      cause: map['cause'],
      format: map['format'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubSet.fromJson(String source) => SubSet.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubSet(subSetId: $subSetId title: $title, destination: $destination, description: $description, imageUrl: $imageUrl, imageFile: $imageFile, cause: $cause, format: $format)';
  }

  @override
  List<Object?> get props => [
        subSetId,
        title,
        destination,
        description,
        imageUrl,
        imageFile,
        cause,
        format
      ];
}

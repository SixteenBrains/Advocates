import 'dart:io';

import '/config/paths.dart';
import '/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final AppUser? author;

  const SubSet({
    this.subSetId,
    this.title,
    this.destination,
    this.description,
    this.imageUrl,
    this.imageFile,
    required this.cause,
    required this.format,
    this.author,
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
    AppUser? author,
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
      author: author ?? this.author,
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
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author?.uid)
    };
  }

  static Future<SubSet?> fromDocument(DocumentSnapshot? snap) async {
    if (snap == null) {
      return null;
    }

    final data = snap.data() as Map?;
    if (data == null) {
      return null;
    }

    final authorRef = data['author'] as DocumentReference?;
    final authorSnap = await authorRef?.get();

    return SubSet(
      author: AppUser.fromDocument(authorSnap),
      cause: data['cause'],
      subSetId: snap.id,
      title: data['title'],
      destination: data['destination'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      format: data['format'] != null
          ? EnumToString.fromString(FileType.values, data['format'])
          : null,
    );
  }

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

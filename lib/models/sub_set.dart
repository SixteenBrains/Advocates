import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class SubSet extends Equatable {
  final String? title;
  final String? destination;
  final String? description;
  final String? imageUrl;
  final File? imageFile;

  const SubSet({
    this.title,
    this.destination,
    this.description,
    this.imageUrl,
    this.imageFile,
  });

  SubSet copyWith({
    String? title,
    String? destination,
    String? description,
    String? imageUrl,
    File? imageFile,
  }) {
    return SubSet(
      title: title ?? this.title,
      destination: destination ?? this.destination,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'destination': destination,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory SubSet.fromMap(Map<String, dynamic> map) {
    return SubSet(
      title: map['title'],
      destination: map['destination'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubSet.fromJson(String source) => SubSet.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubSet(title: $title, destination: $destination, description: $description, imageUrl: $imageUrl, imageFile: $imageFile)';
  }

  @override
  List<Object?> get props =>
      [title, destination, description, imageUrl, imageFile];
}

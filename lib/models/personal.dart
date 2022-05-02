import 'dart:convert';

import 'package:equatable/equatable.dart';

class Personal extends Equatable {
  final String? age;
  final String? gender;
  final String? language;
  final String? relationship;

  const Personal({
    this.age,
    this.gender,
    this.language,
    this.relationship,
  });

  Personal copyWith({
    String? age,
    String? gender,
    String? language,
    String? relationship,
  }) {
    return Personal(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      language: language ?? this.language,
      relationship: relationship ?? this.relationship,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'gender': gender,
      'language': language,
      'relationship': relationship,
    };
  }

  factory Personal.fromMap(Map<String, dynamic> map) {
    return Personal(
      age: map['age'],
      gender: map['gender'],
      language: map['language'],
      relationship: map['relationship'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Personal.fromJson(String source) =>
      Personal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Personal(age: $age, gender: $gender, language: $language, relationship: $relationship)';
  }

  @override
  List<Object?> get props => [age, gender, language, relationship];
}

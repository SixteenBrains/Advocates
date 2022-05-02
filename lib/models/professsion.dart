import 'dart:convert';

import 'package:equatable/equatable.dart';

class Profession extends Equatable {
  final String? role;
  final String? title;
  final String? industry;
  final String? skill;

  const Profession({
    this.role,
    this.title,
    this.industry,
    this.skill,
  });

  Profession copyWith({
    String? role,
    String? title,
    String? industry,
    String? skill,
  }) {
    return Profession(
      role: role ?? this.role,
      title: title ?? this.title,
      industry: industry ?? this.industry,
      skill: skill ?? this.skill,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'title': title,
      'industry': industry,
      'skill': skill,
    };
  }

  factory Profession.fromMap(Map<String, dynamic> map) {
    return Profession(
      role: map['role'],
      title: map['title'],
      industry: map['industry'],
      skill: map['skill'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profession.fromJson(String source) =>
      Profession.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profession(role: $role, title: $title, industry: $industry, skill: $skill)';
  }

  @override
  List<Object?> get props => [role, title, industry, skill];
}

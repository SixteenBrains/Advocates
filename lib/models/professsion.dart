import 'dart:convert';

import 'package:equatable/equatable.dart';

class Profession extends Equatable {
  final String? role;
  final String? title;
  final String? industry;
  final String? skill;
  final String? sector;

  const Profession({
    this.role,
    this.title,
    this.industry,
    this.skill,
    this.sector,
  });

  Profession copyWith({
    String? role,
    String? title,
    String? industry,
    String? skill,
    String? sector,
  }) {
    return Profession(
      role: role ?? this.role,
      title: title ?? this.title,
      industry: industry ?? this.industry,
      skill: skill ?? this.skill,
      sector: sector?? this.sector,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'title': title,
      'industry': industry,
      'skill': skill,
      'sector': sector,
    };
  }

  factory Profession.fromMap(Map<String, dynamic> map) {
    return Profession(
      role: map['role'],
      title: map['title'],
      industry: map['industry'],
      skill: map['skill'],
      sector: map['sector'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profession.fromJson(String source) =>
      Profession.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profession(role: $role, title: $title, industry: $industry, skill: $skill, sector $sector)';
  }

  @override
  List<Object?> get props => [role, title, industry, skill, sector];
}

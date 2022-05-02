import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/models/education.dart';
import '/models/location.dart';
import '/models/personal.dart';
import '/models/professsion.dart';

class User extends Equatable {
  final Personal? personal;
  final Profession? profession;
  final Location? location;
  final Education? education;

  const User({
    this.personal,
    this.profession,
    this.location,
    this.education,
  });

  User copyWith({
    Personal? personal,
    Profession? profession,
    Location? location,
    Education? education,
  }) {
    return User(
      personal: personal ?? this.personal,
      profession: profession ?? this.profession,
      location: location ?? this.location,
      education: education ?? this.education,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'personal': personal?.toMap(),
      'profession': profession?.toMap(),
      'location': location?.toMap(),
      'education': education?.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      personal:
          map['personal'] != null ? Personal.fromMap(map['personal']) : null,
      profession: map['profession'] != null
          ? Profession.fromMap(map['profession'])
          : null,
      location:
          map['location'] != null ? Location.fromMap(map['location']) : null,
      education:
          map['education'] != null ? Education.fromMap(map['education']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(personal: $personal, profession: $profession, location: $location, education: $education)';
  }

  @override
  List<Object?> get props => [personal, profession, location, education];
}

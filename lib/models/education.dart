import 'dart:convert';

import 'package:equatable/equatable.dart';

class Education extends Equatable {
  final String? lavel;
  final String? award;
  final String? graduation;
  final String? duration;

  const Education({
    this.lavel,
    this.award,
    this.graduation,
    this.duration,
  });

  Education copyWith({
    String? lavel,
    String? award,
    String? graduation,
    String? duration,
  }) {
    return Education(
      lavel: lavel ?? this.lavel,
      award: award ?? this.award,
      graduation: graduation ?? this.graduation,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lavel': lavel,
      'award': award,
      'graduation': graduation,
      'duration': duration,
    };
  }

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      lavel: map['lavel'],
      award: map['award'],
      graduation: map['graduation'],
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Education.fromJson(String source) =>
      Education.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Education(lavel: $lavel, award: $award, graduation: $graduation, duration: $duration)';
  }

  @override
  List<Object?> get props => [lavel, award, graduation, duration];
}

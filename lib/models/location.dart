import 'dart:convert';

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String? region;
  final String? country;
  final String? state;
  final String? city;

  const Location({
    this.region,
    this.country,
    this.state,
    this.city,
  });

  Location copyWith({
    String? region,
    String? country,
    String? state,
    String? city,
  }) {
    return Location(
      region: region ?? this.region,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'region': region,
      'country': country,
      'state': state,
      'city': city,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      region: map['region'],
      country: map['country'],
      state: map['state'],
      city: map['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Location(region: $region, country: $country, state: $state, city: $city)';
  }

  @override
  List<Object?> get props {
    return [
      region,
      country,
      state,
      city,
    ];
  }
}

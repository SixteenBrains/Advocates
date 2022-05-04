import '/models/preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '/models/education.dart';
import '/models/location.dart';
import '/models/personal.dart';
import '/models/professsion.dart';

class AppUser extends Equatable {
  final String? email;
  final String? name;
  final String? uid;
  final String? profilePic;
  final Personal? personal;
  final Profession? profession;
  final Location? location;
  final Education? education;
  final String? format;
  final List<String?> causes;
  // final Preferences? preferences;
  final DateTime? createdAt;

  const AppUser({
    this.email,
    this.name,
    this.uid,
    this.profilePic,
    this.personal,
    this.profession,
    this.location,
    this.education,
    this.createdAt,
    this.format,
    this.causes = const [],
    // this.preferences,
  });

  AppUser copyWith({
    String? email,
    String? name,
    String? uid,
    String? profilePic,
    Personal? personal,
    Profession? profession,
    Location? location,
    Education? education,
    DateTime? createdAt,
    Preferences? preferences,
    String? format,
    List<String?>? causes,
  }) {
    return AppUser(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      personal: personal ?? this.personal,
      profession: profession ?? this.profession,
      location: location ?? this.location,
      education: education ?? this.education,
      createdAt: createdAt ?? this.createdAt,
      format: format ?? this.format,
      causes: causes ?? this.causes,
      // preferences: preferences ?? this.preferences,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'personal': personal?.toMap(),
      'profession': profession?.toMap(),
      'location': location?.toMap(),
      'education': education?.toMap(),
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,

      /// createdAt?.millisecondsSinceEpoch,
      //'preferences': preferences?.toMap(),
      'format': format ?? 'IMAGES',
      'causes': causes,
    };
  }

  // factory AppUser.fromMap(Map<String, dynamic> map) {
  //   return AppUser(
  //     email: map['email'],
  //     name: map['name'],
  //     uid: map['uid'],
  //     profilePic: map['profilePic'],
  //     personal:
  //         map['personal'] != null ? Personal.fromMap(map['personal']) : null,
  //     profession: map['profession'] != null
  //         ? Profession.fromMap(map['profession'])
  //         : null,
  //     location:
  //         map['location'] != null ? Location.fromMap(map['location']) : null,
  //     education:
  //         map['education'] != null ? Education.fromMap(map['education']) : null,
  //     createdAt: map['createdAt'] != null
  //         ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
  //         : null,
  //   );
  // }

  static AppUser? fromDocument(DocumentSnapshot? snap) {
    final data = snap?.data() as Map?;

    if (data == null) {
      return null;
    }

    return AppUser(
      email: data['email'],
      name: data['name'],
      uid: data['uid'],
      profilePic: data['profilePic'],
      personal:
          data['personal'] != null ? Personal.fromMap(data['personal']) : null,
      profession: data['profession'] != null
          ? Profession.fromMap(data['profession'])
          : null,
      location:
          data['location'] != null ? Location.fromMap(data['location']) : null,
      education: data['education'] != null
          ? Education.fromMap(data['education'])
          : null,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      format: data['format'],
      causes: data['causes'] != null ? List.from(data['causes']) : [],
    );
  }

  @override
  String toString() {
    return 'AppUser(email: $email, name: $name, uid: $uid, profilePic: $profilePic, personal: $personal, profession: $profession, location: $location, education: $education, createdAt: $createdAt, causes: $causes)';
  }

  @override
  List<Object?> get props {
    return [
      email,
      name,
      uid,
      profilePic,
      personal,
      profession,
      location,
      education,
      createdAt,
      format,
      causes,
    ];
  }
}

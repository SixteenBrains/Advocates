import 'package:advocates/config/paths.dart';
import 'package:advocates/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import '/models/sub_set.dart';
import 'package:file_picker/file_picker.dart';

class SetModel extends Equatable {
  final String? name;
  final String? cause;
  final FileType? format;
  final List<SubSet?> subsets;
  final AppUser? author;

  const SetModel({
    this.name,
    this.cause,
    this.format,
    this.subsets = const [],
    this.author,
  });

  SetModel copyWith({
    String? name,
    String? cause,
    FileType? format,
    List<SubSet?>? subsets,
    AppUser? author,
  }) {
    return SetModel(
      name: name ?? this.name,
      cause: cause ?? this.cause,
      format: format ?? this.format,
      subsets: subsets ?? this.subsets,
      author: author ?? this.author,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'name': name,
  //     'cause': cause,
  //     'format': EnumToString.convertToString(format),
  //     'subsets': subsets.map((x) => x?.toMap()).toList(),
  //   };
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'name': name,
  //     'cause': cause,
  //     'format': EnumToString.convertToString(format),
  //     // 'subsets': subsets.map((x) => x?.toMap()).toList(),
  //     'subsets': subsets.map((subset) => subset?.subSetId).toList(),
  //   };
  // }

  Map<String, dynamic> toMap({required String subSetId}) {
    return {
      'name': name,
      'cause': cause,
      'format': EnumToString.convertToString(format),
      // 'subsets': subsets.map((x) => x?.toMap()).toList(),
      // 'subsets': subsets.map((subset) => subset?.subSetId).toList(),
      'subsets': [subSetId],
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author?.uid)
    };
  }

  static Future<SetModel?> fromDocument(DocumentSnapshot? snap) async {
    if (snap == null) {
      return null;
    }

    final data = snap.data() as Map?;
    if (data == null) {
      return null;
    }

    final authorRef = data['author'] as DocumentReference?;
    final authorSnap = await authorRef?.get();

    List<SubSet?> subSets = [];

    final subSetsList =
        data['subsets'] != null ? List.from(data['subsets']) : [];

    for (var item in subSetsList) {
      final subSetSnap = await FirebaseFirestore.instance
          .collection(Paths.subsets)
          .doc(item)
          .get();
      subSets.add(await SubSet.fromDocument(subSetSnap));
    }

    return SetModel(
      author: AppUser.fromDocument(authorSnap),
      name: data['name'],
      cause: data['cause'],
      format: EnumToString.fromString(FileType.values, data['format']),
      subsets: subSets,
    );
  }

  // factory SetModel.fromMap(Map<String, dynamic> map) {
  //   return SetModel(
  //     name: map['name'],
  //     cause: map['cause'],
  //     format: EnumToString.fromString(FileType.values, map['format']),
  //     subsets: map['subsets'] != null
  //         ? List<SubSet?>.from(map['subsets']?.map((x) => SubSet.fromMap(x)))
  //         : [],
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory SetModel.fromJson(String source) =>
  //     SetModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Set(name: $name, cause: $cause, format: $format, subsets: $subsets)';
  }

  @override
  List<Object?> get props => [name, cause, format, subsets];
}

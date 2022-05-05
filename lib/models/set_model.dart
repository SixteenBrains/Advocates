import '/enums/enums.dart';
import '/config/paths.dart';
import '/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import '/models/sub_set.dart';

class SetModel extends Equatable {
  final String? setId;
  final String? name;
  final String? cause;
  final MediaFormat? mediaFormat;
  final List<SubSet?> subsets;
  final AppUser? author;

  const SetModel({
    this.setId,
    this.name,
    this.cause,
    this.mediaFormat,
    this.subsets = const [],
    this.author,
  });

  SetModel copyWith({
    String? setId,
    String? name,
    String? cause,
    MediaFormat? mediaFormat,
    List<SubSet?>? subsets,
    AppUser? author,
  }) {
    return SetModel(
      setId: setId ?? this.setId,
      name: name ?? this.name,
      cause: cause ?? this.cause,
      mediaFormat: mediaFormat ?? this.mediaFormat,
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
      'mediaFormat': EnumToString.convertToString(mediaFormat),
      // 'subsets': subsets.map((x) => x?.toMap()).toList(),
      // 'subsets': subsets.map((subset) => subset?.subSetId).toList(),
      'subsets': [subSetId],
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author?.uid)
    };
  }

  factory SetModel.fromMap(Map<String, dynamic> map) {
    return SetModel(
      name: map['name'],
      cause: map['cause'],
      mediaFormat:
          EnumToString.fromString(MediaFormat.values, map['mediaFormat']),
      subsets: const [],
    );
  }

  static Future<SetModel?> fromDocument(DocumentSnapshot? snap) async {
    try {
      if (snap == null) {
        return null;
      }

      final data = snap.data() as Map?;
      if (data == null) {
        return null;
      }

      print('Set model data $data');

      final authorRef = data['author'] as DocumentReference?;
      final authorSnap = await authorRef?.get();

      List<SubSet?> subSets = [];

      final subSetsList =
          data['subsets'] != null ? List.from(data['subsets']) : [];

      print('Subsets list $subSetsList');

      for (var item in subSetsList) {
        final subSetSnap = await FirebaseFirestore.instance
            .collection(Paths.subsets)
            .doc(item)
            .get();

        print('item sin -- ${subSetSnap.data()}');

        print('aaaa ak $subSetSnap');

        // final subSet = await SubSet.fromDocument(subSetSnap);
        // print('alkalala $subSet');
        subSets.add(await SubSet.fromDocument(subSetSnap));
      }

      return SetModel(
        //setId: ,
        setId: snap.id,
        author: AppUser.fromDocument(authorSnap),
        name: data['name'],
        cause: data['cause'],
        mediaFormat:
            EnumToString.fromString(MediaFormat.values, data['mediaFormat']),
        subsets: subSets,
      );
    } catch (error) {
      print('Error in getting set model ${error.toString()}');
      return null;
    }
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
    return 'Set(setId: $setId, name: $name, cause: $cause, format: $mediaFormat, subsets: $subsets, setId,)';
  }

  @override
  List<Object?> get props => [setId, name, cause, mediaFormat, subsets];
}
//d8489aa0-d60a-4a92-8721-01eaca8f6a9d
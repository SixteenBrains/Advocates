import 'dart:io';

import '/models/set_model.dart';

import '/enums/enums.dart';
import '/config/paths.dart';
import '/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

class SubSet extends Equatable {
  final String? subSetId;
  final String? title;
  final MediaFormat? mediaFormat;
  final String? destination;
  final String? description;
  final String? imageUrl;
  final File? imageFile;
  final AppUser? author;
  final SetModel? setModel;
  // final int? views;
  // final int? likes;
  // final int? visits;

  final Set<String?> views;
  final Set<String?> likes;
  final Set<String?> visits;

  const SubSet({
    this.mediaFormat,
    this.subSetId,
    this.destination,
    this.description,
    this.imageUrl,
    this.imageFile,
    this.setModel,
    this.author,
    this.title,
    this.likes = const {},
    this.views = const {},
    this.visits = const {},
  });

  SubSet copyWith({
    String? title,
    String? subSetId,
    String? destination,
    String? description,
    String? imageUrl,
    File? imageFile,
    String? cause,
    MediaFormat? mediaFormat,
    AppUser? author,
    SetModel? setModel,
    Set<String?>? views,
    Set<String?>? likes,
    Set<String?>? visits,
  }) {
    return SubSet(
      title: title ?? this.title,
      subSetId: subSetId ?? this.subSetId,
      setModel: setModel ?? this.setModel,
      destination: destination ?? this.destination,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      imageFile: imageFile ?? this.imageFile,
      mediaFormat: mediaFormat ?? this.mediaFormat,
      author: author ?? this.author,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      visits: visits ?? this.visits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'destination': destination,
      'description': description,
      'imageUrl': imageUrl,
      'mediaFormat': EnumToString.convertToString(mediaFormat),
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author?.uid),
      'setModel': FirebaseFirestore.instance
          .collection(Paths.sets)
          .doc(setModel?.setId),
      'views': views.toList(),
      'likes': likes.toList(),
      'visits': visits.toList(),
    };
  }

  static Future<SubSet?> fromDocument(DocumentSnapshot? snap) async {
    if (snap == null) {
      return null;
    }

    final data = snap.data() as Map?;
    if (data == null) {
      return null;
    }

    final authorRef = data['author'] as DocumentReference?;
    final authorSnap = await authorRef?.get();

    final setRef = data['setModel'] as DocumentReference?;
    final setSnap = await setRef?.get();
    print('Set snap $setSnap');
    print('Sub set data ${setSnap?.data()}');

    final setData = setSnap?.data() as Map<String, dynamic>?;
    final setModel = setData != null ? SetModel.fromMap(setData) : null;
    //await SetModel.fromDocument(setSnap);

    //print('Set model 33 $setModel');

    print('sub set data 2 $data');
    return SubSet(
      author: AppUser.fromDocument(authorSnap),
      subSetId: snap.id,
      title: data['title'],
      destination: data['destination'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      mediaFormat: data['mediaFormat'] != null
          ? EnumToString.fromString(MediaFormat.values, data['mediaFormat'])
          : null,
      setModel: setModel,
      views: data['views'] != null ? Set.from(data['views']) : {},
      likes: data['likes'] != null ? Set.from(data['likes']) : {},
      visits: data['visits'] != null ? Set.from(data['visits']) : {},
    );
  }

  @override
  String toString() {
    return 'SubSet (title: $title, subSetId: $subSetId, destination: $destination, description: $description, imageUrl: $imageUrl, imageFile: $imageFile, views: $views ,likes: $likes, visits: $visits)';
  }

  @override
  List<Object?> get props => [
        title,
        subSetId,
        setModel,
        destination,
        description,
        imageUrl,
        imageFile,
        views,
        likes,
        visits,
      ];
}

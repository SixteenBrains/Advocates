import 'dart:io';
import '/enums/enums.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/set_model.dart';
import '/models/sub_set.dart';
import '/repositories/set/set_repository.dart';
import '/models/failure.dart';
import '/utils/file_util.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'set_state.dart';

class SetCubit extends Cubit<SetState> {
  final SetRepository _setRepository;
  final AuthBloc _authBloc;
  SetCubit({
    required SetRepository setRepository,
    required AuthBloc authBloc,
  })  : _setRepository = setRepository,
        _authBloc = authBloc,
        super(SetState.initial());

  void nameChanged(String value) {
    emit(state.copyWith(name: value, status: SetStatus.initial));
  }

  void causeChanged(String? value) {
    emit(state.copyWith(cause: value, status: SetStatus.initial));
  }

  // void changeFormat(String? format) {
  //   FileType? type;
  //   //'GIFs', 'IMAGES', 'VIDEOS
  //   if (format == 'IMAGES') {
  //     type = FileType.image;
  //   } else if (format == 'IMAGES') {
  //     type = FileType.video;
  //   }
  //   emit(state.copyWith(
  //       format: format, fileType: type, status: SetStatus.initial));
  // }

  void changeFormat(String? format) {
    print('change format - $format');
    MediaFormat? mediaFormat;

    // if (format == 'VIDEOS') {
    //   mediaFormat = MediaFormat.videos;
    // } else {}
    //'GIFs', 'IMAGES', 'VIDEOS
    if (format == 'IMAGES') {
      mediaFormat = MediaFormat.images;
    } else if (format == 'VIDEOS') {
      mediaFormat = MediaFormat.videos;
    } else if (format == 'GIFS') {
      mediaFormat = MediaFormat.gifs;
    }
    emit(state.copyWith(
        format: format, mediaFormat: mediaFormat, status: SetStatus.initial));
  }

  void pickedFileChanged({required MediaFormat mediaFormat}) async {
    final pickedFile = await FileUtil.pickedFile(mediaFormat);
    print('cubit picked file $pickedFile');
    emit(state.copyWith(pickedFile: pickedFile, status: SetStatus.initial));
  }

  void addSubSet(SubSet subSet) async {
    try {
      if (state.subSets.length < 7) {
        final List<SubSet?> subSets = List.from(state.subSets)..add(subSet);
        emit(state.copyWith(subSets: subSets, status: SetStatus.initial));
      }
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SetStatus.error));
    }
  }
  // sub set

  void subSetTitleChanged(String value) {
    emit(state.copyWith(subSetTitle: value, status: SetStatus.initial));
  }

  void subSetDestinationChanged(String value) {
    emit(state.copyWith(subSetDestination: value, status: SetStatus.initial));
  }

  void subSetDescriptionChanged(String value) {
    emit(state.copyWith(subSetdescription: value, status: SetStatus.initial));
  }

  //
  void uploadSubSet({required SetModel? setModel}) async {
    try {
      emit(state.copyWith(status: SetStatus.loading));

      final imageUrl = state.pickedFile != null
          ? await FileUtil.uploadImageToStorage('subsets', state.pickedFile!)
          : null;

      final subSet = SubSet(
        setModel: setModel,
        mediaFormat: setModel?.mediaFormat,
        imageUrl: imageUrl,
        description: state.subSetdescription,
        destination: state.subSetDestination,
        author: _authBloc.state.user,
      );

      await _setRepository.uploadSubSet(setModel: setModel, subSet: subSet);

      emit(state.copyWith(status: SetStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SetStatus.error));
    }
  }

  void loadUserSets() async {
    try {
      emit(state.copyWith(status: SetStatus.loading));

      final sets =
          await _setRepository.getUserSets(userId: _authBloc.state.user?.uid);

      print('Sets ------- $sets');
      emit(state.copyWith(sets: sets, status: SetStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SetStatus.error));
    }
  }

  void loadSetValues({required SetModel? setModel}) {
    emit(
      state.copyWith(
        name: setModel?.name,
        cause: setModel?.cause,
        mediaFormat: setModel?.mediaFormat,
      ),
    );
  }

  void deleteSet({required String? setId}) async {
    try {
      if (setId == null) {
        return;
      }
      await _setRepository.deleteSet(setId: setId);
      loadUserSets();
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SetStatus.error));
    }
  }
}

// void uploadSet() async {
//   try {
//     emit(state.copyWith(status: SetStatus.loading));

//     List<SubSet?> subSets = [];

//     for (var subSet in state.subSets) {
//       if (subSet?.imageFile != null) {
//         final imageUrl =
//             await FileUtil.uploadImageToStorage('sets', subSet!.imageFile!);
//         final updatedSubSet = subSet.copyWith(imageUrl: imageUrl);
//         subSets.add(updatedSubSet);
//       }
//     }

//     final set = SetModel(
//       subsets: subSets,
//       name: state.name,
//       cause: state.cause,
//       format: state.fileType,
//     );
//     // final id =
//     // await _setRepository.uploadSet(set);

//     emit(state.copyWith(status: SetStatus.succuss));
//   } on Failure catch (failure) {
//     emit(state.copyWith(failure: failure, status: SetStatus.error));
//   }
// }

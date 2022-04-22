import 'dart:io';
import '/models/set_model.dart';
import '/models/sub_set.dart';
import '/repositories/set/set_repository.dart';
import 'package:file_picker/file_picker.dart';
import '/models/failure.dart';
import '/utils/file_util.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'set_state.dart';

class SetCubit extends Cubit<SetState> {
  final SetRepository _setRepository;
  SetCubit({required SetRepository setRepository})
      : _setRepository = setRepository,
        super(SetState.initial());

  void nameChanged(String value) {
    emit(state.copyWith(name: value, status: SetStatus.initial));
  }

  void causeChanged(String? value) {
    emit(state.copyWith(cause: value, status: SetStatus.initial));
  }

  void changeFormat(String? format) {
    FileType? type;
    //'GIFs', 'IMAGES', 'VIDEOS
    if (format == 'IMAGES') {
      type = FileType.image;
    } else if (format == 'IMAGES') {
      type = FileType.video;
    }
    emit(state.copyWith(
        format: format, fileType: type, status: SetStatus.initial));
  }

  void pickedFileChanged() async {
    final pickedFile = await FileUtil.pickedFile(state.fileType);
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

  void uploadSet() async {
    try {
      emit(state.copyWith(status: SetStatus.loading));

      List<SubSet?> subSets = [];

      for (var subSet in state.subSets) {
        if (subSet?.imageFile != null) {
          final imageUrl =
              await FileUtil.uploadImageToStorage('sets', subSet!.imageFile!);
          final updatedSubSet = subSet.copyWith(imageUrl: imageUrl);
          subSets.add(updatedSubSet);
        }
      }

      final set = SetModel(
        subsets: subSets,
        name: state.name,
        cause: state.cause,
        format: state.fileType,
      );
      // final id =
      await _setRepository.uploadSet(set);

      emit(state.copyWith(status: SetStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SetStatus.error));
    }
  }
}

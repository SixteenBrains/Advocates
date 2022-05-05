import 'dart:io';

import 'package:advocates/enums/enums.dart';
import 'package:advocates/models/failure.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FileUtil {
  static Future<File?> pickedFile(MediaFormat mediaFormat) async {
    try {
      //  add custom file picker ofot gfg

      // FilePickerResult? result = await FilePicker.platform.pickFiles(
      //   type: FileType.custom,
      //   // allowedExtensions: ['jpg', 'pdf', 'doc'],
      //   allowedExtensions: ['gif'],
      // );

      FileType fileType;

      switch (mediaFormat) {
        case MediaFormat.videos:
          fileType = FileType.video;
          break;

        default:
          fileType = FileType.media;
          break;
      }

      File? pickedFile;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        // allowedExtensions: [
        //   //'mp4',
        // ],
        type: fileType,
      );

      if (result != null) {
        pickedFile = File(result.files.single.path!);
      } else {
        // User canceled the picker
      }
      print('Picked file ---- $pickedFile');
      return pickedFile;
    } catch (error) {
      print('Error in picking file ${error.toString()}');
      throw const Failure(message: 'Error in picking file');
    }
  }

  static Future<String> uploadImageToStorage(
    String childName,
    File file,
    //String id,
  ) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    // creating location to our firebase storage

    Reference ref = _storage.ref().child(childName).child(const Uuid().v1());
    // if (isPost) {
    //   String id = const Uuid().v1();
    //   ref = ref.child(id);
    // }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file.readAsBytesSync());

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

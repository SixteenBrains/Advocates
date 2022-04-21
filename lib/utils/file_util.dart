import 'dart:io';

import 'package:advocates/models/failure.dart';
import 'package:file_picker/file_picker.dart';

class FileUtil {
  static Future<File?> pickedFile() async {
    try {
      File? pickedFile;
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        pickedFile = File(result.files.single.path!);
      } else {
        // User canceled the picker
      }
      return pickedFile;
    } catch (error) {
      print('Error in picking file ${error.toString()}');
      throw const Failure(message: 'Error in picking file');
    }
  }
}

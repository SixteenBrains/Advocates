import '/models/failure.dart';
import '/enums/enums.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

class SocialShareService {
  static Future<String?> socialShare(
    SharePlatform platform, {
    required String? inviteUrl,
    required String? text,
    required FileType mediaType,
  }) async {
    try {
      // String mediaPath;
      // // _storyController.pause();
      // if (storyUrl != null) {
      //   final response = await http.get(Uri.parse(storyUrl));

      //   final bytes = response.bodyBytes;
      //   final temp = await getTemporaryDirectory();
      //   print('Paths of media ${temp.path}');
      //   mediaPath = mediaType == FileType.video
      //       ? '${temp.path}/video.mp4'
      //       : '${temp.path}/image.jpg';
      //   // final imagePath = '${temp.path}/image.jpg';
      //   //  final imagePath = '${temp.path}/videos.mp4';
      //   File(mediaPath).writeAsBytesSync(bytes);
      //   print('Image path --$mediaPath');
      String? shareResponse;
      final FlutterShareMe flutterShareMe = FlutterShareMe();

      switch (platform) {
        case SharePlatform.messenger:
          shareResponse = await flutterShareMe.shareToMessenger(
            msg: text ?? '',
            //url: inviteUrl ?? '',
          );
          break;

        case SharePlatform.whatsapp:
          // await flutterShareMe.shareToMessenger(
          //     msg: text ?? '', url: storyUrl);
          shareResponse = await flutterShareMe.shareToWhatsApp(
            //   imagePath: mediaPath,
            // msg: text ?? '' + (inviteUrl ?? ''),
            msg: text ?? '',
            // fileType: mediaType,
          );
          break;

        case SharePlatform.facebook:
          shareResponse = await flutterShareMe.shareToFacebook(
              // url: storyUrl, msg: text ?? '');
              msg: text ?? '' + (inviteUrl ?? ''));

          break;

        // case SharePlatform.instagram:
        //   shareResponse = await flutterShareMe.shareToInstagram(
        //     filePath: mediaPath,
        //     fileType: mediaType,
        //   );

        // break;
        default:
          print('Share response $shareResponse');
          // return shareResponse == 'success';
          return shareResponse;
      }
      return 'Something went wrong, pleae try again';
    } catch (error) {
      print('Error in sending content ${error.toString()}');
      throw const Failure(message: 'Error in sending content');
    }
  }
}


//#Pkrkroy9973
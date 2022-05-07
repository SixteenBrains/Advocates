import '/enums/enums.dart';
import '/constants/constants.dart';
import '/screens/set/update_set_screen.dart';
import '/screens/set/set_manager.dart';
import '/models/set_model.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/set/widgets/show_set_media.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SetCard extends StatelessWidget {
  final SetModel? setModel;
  final VoidCallback onDelete;
  const SetCard({Key? key, required this.setModel, required this.onDelete})
      : super(key: key);

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/modal_warning.png',
                height: 64.0,
                width: 64.0,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'This action cannot be reversed, are you sure you want to do this?',
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 45.0,
                width: 200.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colorBrighest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onPressed: () {
                    onDelete();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'CONFIRM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          //  SingleChildScrollView(
          //   child: ListBody(
          //     children: const <Widget>[
          //       Text('This is a demo alert dialog.'),
          //       Text('Would you like to approve of this message?'),
          //     ],
          //   ),
          // ),
          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('Approve'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('formate -- ${setModel?.mediaFormat}');
    final _canvas = MediaQuery.of(context).size;
    final List<double> stops =
        setModel?.mediaFormat == FileType.image ? [0.2, 0.7] : [0.2, 0.5];
    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        print('drag ${data.primaryDelta?.ceil()}');
        final offSet = data.primaryDelta?.ceil() ?? 0;
        if (offSet > 0) {
          // right swipe
          print('Right swipe');
          Navigator.of(context).pushNamed(
            UpdateSetScreen.routeName,
            arguments: UpDateSetArgs(setModel: setModel),
          );
        } else {
          // left swipe
          print('left swipe');
          _showMyDialog(context);
        }
      },
      onTap: () => Navigator.of(context).pushNamed(
        UpdateSetScreen.routeName,
        arguments: UpDateSetArgs(setModel: setModel),
      ),
      child: Container(
        height: _canvas.height * 0.77,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4],
            colors: [
              Colors.black87,
              Colors.black38,
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          fit: setModel?.mediaFormat == MediaFormat.videos
              ? StackFit.loose
              : StackFit.expand,
          children: [
            // ShowMedia(subSet: setModel),
            ShowSetMedia(setModel: setModel),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  //color: Colors.black12,
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: stops,
                    colors: const [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        setModel?.name ?? '',
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Chip(
                        backgroundColor: const Color(0xff2ED573),
                        label: Text(
                          setModel?.cause ?? 'N/A',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          StatsWidget(
                            iconUrl: 'assets/images/set_views.png',
                            label: 'VIEWS',
                          ),
                          StatsWidget(
                            iconUrl: 'assets/images/set_likes.png',
                            label: 'LIKES',
                          ),
                          StatsWidget(
                            iconUrl: 'assets/images/set_visits.png',
                            label: 'VISITS',
                          ),
                        ],
                      ),

                      const SizedBox(height: 10.0),

                      Center(
                        child: SizedBox(
                          height: 50.0,
                          width: 190.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff2ED573),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(SetManager.routeName),
                            child: const Text(
                              'CREATE',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // DescriptionTextWidget(text: subSet?.description ?? 'N/A'),
                      // Text(
                      //   subSet?.description ?? 'N/A',
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: 16.0,
                      //   ),
                      // ),
                      //   const SizedBox(height: 10.0),
                      // Chip(
                      //   backgroundColor: Colors.green,
                      //   label: Text(
                      //     subSet?.cause ?? '',
                      //     style: const TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 16.0,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 5.0),
                      // Text(
                      //   ' ${subSet?.destination ?? ' '}',
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //   ),
                      // ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

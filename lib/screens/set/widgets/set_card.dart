import '/models/set_model.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/set/widgets/show_set_media.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SetCard extends StatelessWidget {
  final SetModel? setModel;
  const SetCard({Key? key, required this.setModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('formate -- ${setModel?.format}');
    final List<double> stops =
        setModel?.format == FileType.image ? [0.2, 0.7] : [0.2, 0.5];
    return Container(
      height: 500.0,
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
        fit: setModel?.format == FileType.image
            ? StackFit.expand
            : StackFit.loose,
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
                          onPressed: () {},
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
    );
  }
}

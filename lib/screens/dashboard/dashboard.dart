import 'package:avatar_glow/avatar_glow.dart';

import 'package:speech_to_text/speech_to_text.dart';

import '/screens/account/screens/cause_screen.dart';
import '/screens/account/screens/formate_screen.dart';
import '/screens/dashboard/bloc/dashboard_bloc.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/subset_card.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  // late SpeechToText _speechToText;
  // bool _speechEnabled = false;
  // String _lastWords = ' Speak ...';

  // @override
  // void initState() {
  //   super.initState();
  //   _initSpeech();
  // }

  // /// This has to happen only once per app
  // void _initSpeech() async {
  //   _speechToText = SpeechToText();
  //   _speechEnabled = await _speechToText.initialize();

  //   setState(() {});
  //   _startListening();
  //   // if (_speechToText.isNotListening) {
  //   //   _startListening();
  //   // }
  // }

  // /// Each time to start a speech recognition session
  // void _startListening() async {
  //   await _speechToText.listen(onResult: _onSpeechResult);
  //   //context.read<NavBloc>().add(const UpdateIsListening(isListening: true));
  //   setState(() {});
  // }

  // /// Manually stop the active speech recognition session
  // /// Note that there are also timeouts that each platform enforces
  // /// and the SpeechToText plugin supports setting timeouts on the
  // /// listen method.
  // void _stopListening() async {
  //   await _speechToText.stop();
  //   //context.read<NavBloc>().add(const UpdateIsListening(isListening: false));
  //   setState(() {});
  // }

  // /// This is the callback that the SpeechToText plugin calls when
  // /// the platform returns recognized words.
  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     _lastWords = result.recognizedWords;
  //   });
  // }

  late SpeechToText speech;
  String textString = 'Speak to search';
  bool isListen = false;
  double confidence = 1.0;

  void listen() async {
    print('Listen function is called');
    if (!isListen) {
      bool avail = await speech.initialize();
      if (avail) {
        setState(() {
          isListen = true;
        });
        await speech.listen(onResult: (value) {
          setState(() {
            textString = value.recognizedWords;
            if (value.hasConfidenceRating && value.confidence > 0) {
              confidence = value.confidence;
            }
          });
        });
      }
    } else {
      setState(() {
        isListen = false;
      });
      speech.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(InitSpeachToText());
    // speech = SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   mini: true,
      //   backgroundColor: Colors.white,

      //   child: Icon(
      //     isListen ? Icons.clear : Icons.search,
      //     color: Colors.green,
      //   ),
      //   onPressed: () {
      //     listen();
      //     // context
      //     //     .read<DashboardBloc>()
      //     //     .add(const SearchKeyWordChanged(keyWord: 'Ram'));
      //     //  context.read<NavBloc>().add(UpdateIsListening(isListening: false));
      //   },

      //   // : Icon(
      //   //   _speechToText.isNotListening ? Icons.search : Icons.clear,
      //   //   color: Colors.green,
      //   // ),
      // ),

      // ///
      //     FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   mini: true,
      //   onPressed: () {
      //     //  context.read<NavBloc>().add(UpdateIsListening(isListening: false));
      //     // If not yet listening for speech start, otherwise stop
      //     _speechToText.isNotListening ? _startListening() : _stopListening();
      //   },
      //   tooltip: 'Listen',
      //   child: Icon(
      //     _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
      //     color: Colors.green,
      //   ),
      // ),
      //  : null,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60.0,
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(FormateScreen.routeName),
                      child: Image.asset(
                        'assets/images/menu_format.png',
                        height: 40.0,
                        width: 40.0,
                      ),
                    ),
                    Image.asset(
                      'assets/images/image_smallest.png',
                      height: 32.0,
                      width: 32.0,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(CauseScreen.routeName),
                      child: Image.asset(
                        'assets/images/menu_cause.png',
                        height: 40.0,
                        width: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: BlocConsumer<DashboardBloc, DashBoardState>(
                listener: (context, state) {
                  // context.read<DashboardBloc>().add(ListenToSpeech());
                  // if (state.searchStatus == SearchStatus.initial) {
                  //   context.read<DashboardBloc>().add(ListenToSpeech());
                  // }
                },
                builder: (context, state) {
                  if (state.status == DashBoardStatus.loading) {
                    return const LoadingIndicator();
                  }
                  print('Search keyword -- ${state.searchKeyword}');
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: RefreshIndicator(
                          onRefresh: () async =>
                              context.read<DashboardBloc>().add(LoadSubSets()),
                          child: state.subSets.isEmpty
                              ? const Center(
                                  child: Text('No sets found, try again'),
                                )
                              : ListView.builder(
                                  itemCount: state.subSets.length,
                                  itemBuilder: (context, index) {
                                    return SubSetCard(
                                        subSet: state.subSets[index]);
                                  },
                                ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            context.read<DashboardBloc>().add(ListenToSpeech());
                          },
                          child: AvatarGlow(
                            shape: BoxShape.circle,
                            // animate: isListen,
                            animate: true,
                            glowColor: Colors.green,
                            // endRadius: (_lastWords.length * 6.0).toDouble(),
                            endRadius: 65.0,
                            duration: const Duration(milliseconds: 2000),
                            repeatPauseDuration:
                                const Duration(milliseconds: 100),
                            repeat: true,
                            child: Text(
                              // textString,
                              state.searchKeyword ?? 'Tap and speak',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      if (state.searchKeyword != null)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<DashboardBloc>()
                                      .add(LoadSubSets());
                                },
                                icon: const Icon(Icons.search,
                                    color: Colors.green),

                                // IconButton(
                                //   icon: Icon(
                                //       state.searchStatus == SearchStatus.initial
                                //           ? Icons.search
                                //           : Icons.refresh,
                                //       color: Colors.green),
                                //   onPressed: () {
                                //     if (state.searchKeyword != null &&
                                //         state.searchStatus ==
                                //             SearchStatus.initial) {
                                //       print('aaan');
                                //       context
                                //           .read<DashboardBloc>()
                                //           .add(LoadSubSets());
                                //     } else {
                                //       context
                                //           .read<DashboardBloc>()
                                //           .add(ListenToSpeech());
                                //     }
                                //   },
                                // ),
                                // ),
                              ),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatsWidget extends StatelessWidget {
  final String iconUrl;
  final String label;

  const StatsWidget({
    Key? key,
    required this.iconUrl,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      width: 100.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15.0),
          const Text('-0%'),
          const SizedBox(height: 5.0),
          const Text(
            '000',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(label),
          const SizedBox(height: 8.0),
          Image.asset(
            iconUrl,
            height: 40.0,
            width: 40.0,
          )
        ],
      ),
    );
  }
}

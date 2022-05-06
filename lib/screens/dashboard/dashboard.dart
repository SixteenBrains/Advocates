import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
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
  late SpeechToText _speechToText;
  bool _speechEnabled = false;
  String _lastWords = ' Speak ...';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechToText = SpeechToText();
    _speechEnabled = await _speechToText.initialize();

    setState(() {});
    // if (_speechToText.isNotListening) {
    //   _startListening();
    // }
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Recognised words $_lastWords');
    return Scaffold(
      floatingActionButton:

          // ///
          FloatingActionButton(
        backgroundColor: Colors.white,
        mini: true,
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(
          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
          color: Colors.green,
        ),
      ),
      //  : null,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                    listener: ((context, state) {}),
                    builder: (context, state) {
                      if (state.status == DashBoardStatus.loading) {
                        return const LoadingIndicator();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: RefreshIndicator(
                          onRefresh: () async =>
                              context.read<DashboardBloc>().add(LoadSubSets()),
                          child: ListView.builder(
                            itemCount: state.subSets.length,
                            itemBuilder: (context, index) {
                              return SubSetCard(subSet: state.subSets[index]);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AvatarGlow(
                shape: BoxShape.circle,
                // animate: isListen,
                animate: true,
                glowColor: Colors.green,
                // endRadius: (_lastWords.length * 6.0).toDouble(),
                endRadius: 65.0,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(milliseconds: 100),
                repeat: true,
                child: Text(
                  _lastWords,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
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

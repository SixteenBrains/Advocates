import 'package:speech_to_text/speech_to_text.dart';

import '/utils/frequency_counter.dart';
import '/models/sub_set.dart';
import '/blocs/auth/auth_bloc.dart';
import '/models/failure.dart';
import '/repositories/set/set_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashBoardState> {
  final AuthBloc _authBloc;
  final SetRepository _setRepository;

  late SpeechToText speech;

  DashboardBloc({
    required AuthBloc authBloc,
    required SetRepository setRepository,
  })  : _authBloc = authBloc,
        _setRepository = setRepository,
        super(DashBoardState.initial()) {
    print(_authBloc.state.user);
    on<LoadSubSets>((event, emit) async {
      try {
        emit(state.copyWith(status: DashBoardStatus.loading));

        final subSets =
            await _setRepository.getSubSets(userId: _authBloc.state.user?.uid);
        print('Sub sets --- $subSets');

        if (state.searchKeyword != null) {
          List<SubSet?> reqSubSets = [];

          Map<SubSet, int> subSetFrequency = {};

          for (var element in subSets) {
            if (element != null) {
              final description = element.description?.toLowerCase();
              final destination = element.destination?.toLowerCase();
              final title = element.setModel?.name?.toLowerCase();
              int frequency = 0;

              final keyword = state.searchKeyword!.toLowerCase();

              print('Search keyword - $keyword');

              if (description?.contains(keyword) ?? false) {
                print('Search keyword 1 - $keyword');

                final count = FrequencyCounter.frequencyCounter(
                    description ?? '',
                    keyword: keyword);
                print('Description count $count');
                frequency += count;
              }

              if (destination?.contains(keyword) ?? false) {
                print('Search keyword  2 - $keyword');
                // frequency++;//
                final count = FrequencyCounter.frequencyCounter(
                    destination ?? '',
                    keyword: keyword);
                print('Destination count $count');
                frequency += count;
              }

              if (title?.contains(keyword) ?? false) {
                print('Search keyword 3 - $keyword');
                //frequency++;
                frequency += FrequencyCounter.frequencyCounter(title ?? '',
                    keyword: keyword);
              }
              print('Frequency - $frequency');

              if (frequency > 0) {
                // this means the word occured somewhere
                // reqSubSets.add(element);
                subSetFrequency[element] = frequency;
              }

              // var sortedKeys = subSetFrequency.keys.toList(growable: false)
              //   ..sort((k1, k2) =>
              //       subSetFrequency[k1]!.compareTo(subSetFrequency[k2]!));

              reqSubSets = subSetFrequency.keys.toList(growable: false)
                ..sort((k1, k2) =>
                    subSetFrequency[k1]!.compareTo(subSetFrequency[k2]!));

              // print('sorted keys --- $sortedKeys');

              // LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
              //     key: (k) => k, value: (k) => subSetFrequency[k]);
              // print('Sorted map -- $sortedMap');

              // sortedMap.forEach(
              //   (subSet, count) {
              //     reqSubSets.add(subSet);
              //   },
              // );

              print('Subset map $subSetFrequency');
              print('Sub set list $reqSubSets');

              // final reqList = subSets.where(
              //   (element) {
              //     return element?.description?.contains('Ram') ?? false;
              //   },
              // ).toList();

              ///print('Sets qq ${await Future.wait(subSets)}');
              ///
              print('Search keyword ${state.searchKeyword}');

              emit(
                state.copyWith(
                  status: DashBoardStatus.succuss,
                  searchStatus: SearchStatus.initial,

                  // subSets: subSets,
                  subSets: state.searchKeyword != null ? reqSubSets : subSets,
                ),
              );
            }
          }
        } else {
          emit(
            state.copyWith(
              subSets: subSets,
              status: DashBoardStatus.succuss,
              searchStatus: SearchStatus.initial,
            ),
          );
        }
      } on Failure catch (failure) {
        emit(state.copyWith(status: DashBoardStatus.error, failure: failure));
      }
    });

    on<SearchKeyWordChanged>((event, emit) {
      emit(state.copyWith(
        searchKeyword: event.keyWord,
        searchStatus: SearchStatus.speaking,
      ));
      // add(LoadSubSets());
    });

    on<InitSpeachToText>((event, emit) async {
      speech = SpeechToText();
    });

    on<ListenToSpeech>((event, emit) async {
      print('this runs ');
      bool avail = await speech.initialize();
      print('available $avail');
      if (avail) {
        await speech.listen(onResult: (value) {
          print('words -- ${value.recognizedWords}');
          add(SearchKeyWordChanged(keyWord: value.recognizedWords));
          // emit(state.copyWith(
          //     searchKeyword: value.recognizedWords,
          //     searchStatus: SearchStatus.speaking));
          //textString = value.recognizedWords;
        });
      }
    });

    on<StopListening>((event, emit) async {
      speech.stop();
    });

    on<SearchWithKeyWord>((event, emit) async {
      if (state.searchKeyword != null) {
        add(LoadSubSets());
      }
    });
  }
}

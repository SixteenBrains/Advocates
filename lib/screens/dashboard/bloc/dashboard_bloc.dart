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

        List<SubSet?> reqSubSets = [];

        Map<SubSet, int> subSetFrequency = {};

        for (var element in subSets) {
          if (element != null) {
            final description = element.description?.toLowerCase();
            final destination = element.destination?.toLowerCase();
            final title = element.setModel?.name?.toLowerCase();
            int frequency = 0;
            if (description?.contains('ram') ?? false) {
              frequency += FrequencyCounter.frequencyCounter(description ?? '',
                  keyword: 'ram');
            }

            if (destination?.contains('ram') ?? false) {
              // frequency++;//
              final count = FrequencyCounter.frequencyCounter(destination ?? '',
                  keyword: 'ram');
              print('Destination count $count');
              frequency += count;
            }

            if (title?.contains('ram') ?? false) {
              //frequency++;
              frequency += FrequencyCounter.frequencyCounter(title ?? '',
                  keyword: 'ram');
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
          }
        }

        // final reqList = subSets.where(
        //   (element) {
        //     return element?.description?.contains('Ram') ?? false;
        //   },
        // ).toList();

        ///print('Sets qq ${await Future.wait(subSets)}');

        emit(
          state.copyWith(
            status: DashBoardStatus.succuss,
            // subSets: subSets,
            subSets: reqSubSets,
          ),
        );
      } on Failure catch (failure) {
        emit(state.copyWith(status: DashBoardStatus.error, failure: failure));
      }
    });
  }
}

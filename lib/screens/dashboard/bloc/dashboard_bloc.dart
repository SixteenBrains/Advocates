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

        ///print('Sets qq ${await Future.wait(subSets)}');

        emit(state.copyWith(
          status: DashBoardStatus.succuss,
          subSets: subSets,
        ));
      } on Failure catch (failure) {
        emit(state.copyWith(status: DashBoardStatus.error, failure: failure));
      }
    });
  }
}

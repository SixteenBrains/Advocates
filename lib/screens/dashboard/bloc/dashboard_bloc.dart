import '/blocs/auth/auth_bloc.dart';
import '/models/failure.dart';
import '/models/set_model.dart';
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
    on<LoadSets>((event, emit) async {
      try {
        emit(state.copyWith(status: DashBoardStatus.loading));

        final sets = await _setRepository.getSets();

        emit(state.copyWith(status: DashBoardStatus.succuss, sets: sets));
      } on Failure catch (failure) {
        emit(state.copyWith(status: DashBoardStatus.error, failure: failure));
      }
    });
  }
}

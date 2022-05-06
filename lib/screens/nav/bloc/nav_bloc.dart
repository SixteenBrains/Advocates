import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/enums/nav_item.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState.initial()) {
    on<UpdateNavItem>((event, emit) {
      emit(state.copyWith(item: event.item));
    });

    on<UpdateIsListening>((event, emit) {
      emit(state.copyWith(isListening: event.isListening));
    });
  }
}

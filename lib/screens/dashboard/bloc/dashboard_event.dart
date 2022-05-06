part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadSubSets extends DashboardEvent {}

// class UpDateIsListening extends DashboardEvent {
//   final bool isListening;

//   const UpDateIsListening({required this.isListening});
// }

class SearchKeyWordChanged extends DashboardEvent {
  final String keyWord;

  const SearchKeyWordChanged({required this.keyWord});
}

class InitSpeachToText extends DashboardEvent {}

class ListenToSpeech extends DashboardEvent {}

class StopListening extends DashboardEvent {}

class SearchWithKeyWord extends DashboardEvent {}

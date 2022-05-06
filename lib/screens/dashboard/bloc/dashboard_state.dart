part of 'dashboard_bloc.dart';

enum DashBoardStatus { initial, loading, succuss, error }

enum SearchStatus { initial, speaking, searching, error }

class DashBoardState extends Equatable {
  final List<SubSet?> subSets;
  final Failure failure;
  final DashBoardStatus status;
  final bool isListening;
  final String? searchKeyword;
  final SearchStatus searchStatus;

  const DashBoardState({
    required this.subSets,
    required this.failure,
    required this.status,
    this.isListening = true,
    this.searchKeyword,
    required this.searchStatus,
  });

  factory DashBoardState.initial() => const DashBoardState(
        subSets: [],
        failure: Failure(),
        status: DashBoardStatus.initial,
        isListening: true,
        searchKeyword: null,
        searchStatus: SearchStatus.initial,
      );

  @override
  List<Object?> get props =>
      [subSets, failure, status, isListening, searchKeyword, searchStatus];

  DashBoardState copyWith({
    List<SubSet?>? subSets,
    Failure? failure,
    DashBoardStatus? status,
    bool? isListening,
    String? searchKeyword,
    SearchStatus? searchStatus,
  }) {
    return DashBoardState(
      subSets: subSets ?? this.subSets,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      isListening: isListening ?? this.isListening,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      searchStatus: searchStatus ?? this.searchStatus,
    );
  }

  @override
  String toString() =>
      'DashboardState(subSets: $subSets, failure: $failure, status: $status, isListening: $isListening ,searchKeyword: $searchKeyword, searchStatus $searchStatus)';
}

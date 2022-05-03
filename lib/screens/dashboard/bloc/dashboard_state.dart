part of 'dashboard_bloc.dart';

enum DashBoardStatus { initial, loading, succuss, error }

class DashBoardState extends Equatable {
  final List<SubSet?> subSets;
  final Failure failure;
  final DashBoardStatus status;

  const DashBoardState({
    required this.subSets,
    required this.failure,
    required this.status,
  });

  factory DashBoardState.initial() => const DashBoardState(
      subSets: [], failure: Failure(), status: DashBoardStatus.initial);

  @override
  List<Object> get props => [subSets, failure, status];

  DashBoardState copyWith({
    List<SubSet?>? subSets,
    Failure? failure,
    DashBoardStatus? status,
  }) {
    return DashBoardState(
      subSets: subSets ?? this.subSets,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'DashboardState(subSets: $subSets, failure: $failure, status: $status)';
}

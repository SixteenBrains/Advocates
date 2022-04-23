part of 'dashboard_bloc.dart';

enum DashBoardStatus { initial, loading, succuss, error }

class DashBoardState extends Equatable {
  final List<SetModel?> sets;
  final Failure failure;
  final DashBoardStatus status;

  const DashBoardState({
    required this.sets,
    required this.failure,
    required this.status,
  });

  factory DashBoardState.initial() => const DashBoardState(
      sets: [], failure: Failure(), status: DashBoardStatus.initial);

  @override
  List<Object> get props => [sets, failure, status];

  DashBoardState copyWith({
    List<SetModel?>? sets,
    Failure? failure,
    DashBoardStatus? status,
  }) {
    return DashBoardState(
      sets: sets ?? this.sets,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  String toString() =>
      'DashboardState(sets: $sets, failure: $failure, status: $status)';
}

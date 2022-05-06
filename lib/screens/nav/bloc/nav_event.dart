part of 'nav_bloc.dart';

abstract class NavEvent extends Equatable {
  const NavEvent();

  @override
  List<Object> get props => [];
}

class UpdateNavItem extends NavEvent {
  final NavItem item;

  const UpdateNavItem({required this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'UpdateNav { nav: $item }';
}

class UpdateIsListening extends NavEvent {
  final bool isListening;

  const UpdateIsListening({required this.isListening});
  @override
  List<Object> get props => [isListening];
}

part of 'nav_bloc.dart';

abstract class NavState extends Equatable {
  const NavState();
  
  @override
  List<Object> get props => [];
}

class NavInitial extends NavState {}

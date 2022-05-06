part of 'nav_bloc.dart';

class NavState extends Equatable {
  final NavItem item;
  final bool isListening;

  const NavState({
    required this.item,
    this.isListening = true,
  });

  factory NavState.initial() =>
      const NavState(item: NavItem.dashboard, isListening: true);
  @override
  List<Object> get props => [item, isListening];

  @override
  String toString() => 'NavState(item: $item, isListening: $isListening )';

  @override
  bool? get stringify => true;

  NavState copyWith({NavItem? item, bool? isListening}) {
    return NavState(
      item: item ?? this.item,
      isListening: isListening ?? this.isListening,
    );
  }
}

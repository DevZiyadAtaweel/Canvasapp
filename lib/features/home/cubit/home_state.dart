part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final UserModel user;
  final List<ChildModel> children;
  final String? selectedChildId;

  HomeSuccess({
    required this.user,
    required this.children,
    this.selectedChildId,
  });

  HomeSuccess copyWith({
    UserModel? user,
    List<ChildModel>? children,
    String? selectedChildId,
  }) {
    return HomeSuccess(
      user: user ?? this.user,
      children: children ?? this.children,
      selectedChildId: selectedChildId ?? this.selectedChildId,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

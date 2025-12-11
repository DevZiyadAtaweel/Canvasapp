part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final UserModel user;
  final List<ChildModel> children;
  final String? selectedChildId;
  final List<AllDrawingsModel> lastDrawings;

  HomeSuccess({
    required this.user,
    required this.children,
    this.selectedChildId,
    this.lastDrawings = const [],
  });

  HomeSuccess copyWith({
    UserModel? user,
    List<ChildModel>? children,
    String? selectedChildId,
    List<AllDrawingsModel>? lastDrawings,
  }) {
    return HomeSuccess(
      user: user ?? this.user,
      children: children ?? this.children,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      lastDrawings: lastDrawings ?? this.lastDrawings,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

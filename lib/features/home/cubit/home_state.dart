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
  final bool isDrawingsLoading;

  HomeSuccess({
    required this.user,
    required this.children,
    this.selectedChildId,
    this.lastDrawings = const [],
    this.isDrawingsLoading = false,
  });

  HomeSuccess copyWith({
    UserModel? user,
    List<ChildModel>? children,
    String? selectedChildId,
    List<AllDrawingsModel>? lastDrawings,
    bool? isDrawingsLoading,
  }) {
    return HomeSuccess(
      user: user ?? this.user,
      children: children ?? this.children,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      lastDrawings: lastDrawings ?? this.lastDrawings,
      isDrawingsLoading: isDrawingsLoading ?? this.isDrawingsLoading,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

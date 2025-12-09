part of 'all_drawings_cubit.dart';

@immutable
sealed class AllDrawingsState {}

final class AllDrawingsInitial extends AllDrawingsState {}

final class AllDrawingsLoading extends AllDrawingsState {}

final class AllDrawingsLoaded extends AllDrawingsState {
  final List<AllDrawingsModel> drawings;
  AllDrawingsLoaded(this.drawings);
}

final class AllDrawingsError extends AllDrawingsState {
  final String message;
  AllDrawingsError(this.message);
}

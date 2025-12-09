part of 'add_drawing_cubit.dart';

@immutable
sealed class AddDrawingState {}

final class AddDrawingInitial extends AddDrawingState {}

final class AddDrawingLoading extends AddDrawingState {}

final class AddDrawingSuccess extends AddDrawingState {}

final class AddDrawingFailure extends AddDrawingState {
  final String errorMessage;

  AddDrawingFailure(this.errorMessage);
}

part of 'child_details_cubit.dart';

@immutable
abstract class ChildDetailsState {}

class ChildDetailsInitial extends ChildDetailsState {}

class ChildDetailsLoading extends ChildDetailsState {}

class ChildDetailsLoaded extends ChildDetailsState {
  final ChildModel child;

  ChildDetailsLoaded(this.child);
}

class ChildDetailsError extends ChildDetailsState {
  final String message;

  ChildDetailsError(this.message);
}

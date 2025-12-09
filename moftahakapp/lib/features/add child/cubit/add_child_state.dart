part of 'add_child_cubit.dart';

@immutable
abstract class AddChildState {}

class AddChildInitial extends AddChildState {}

class AddChildLoading extends AddChildState {}

class AddChildSuccess extends AddChildState {}

class AddChildFailure extends AddChildState {
  final String message;
  AddChildFailure(this.message);
}

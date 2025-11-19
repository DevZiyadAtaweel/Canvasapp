part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}

class AuthPasswordResetEmailSent extends AuthState {}

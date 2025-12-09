part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

// حالات التنقّل
class SplashToOnBoarding extends SplashState {}

class SplashToAuth extends SplashState {}

class SplashToHome extends SplashState {}

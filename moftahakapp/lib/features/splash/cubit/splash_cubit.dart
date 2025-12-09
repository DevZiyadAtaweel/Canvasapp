import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAppStart() async {
    emit(SplashLoading());

    // بس عشان اللوجو يبين شوي
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final bool isFirstOpen = prefs.getBool('is_first_open') ?? true;

    if (isFirstOpen) {
      // أول مرة يفتح التطبيق → onBoarding
      emit(SplashToOnBoarding());
      return;
    }

    // مش أول مرة → نشوف هل عامل لوج إن ولا لا
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // مش عامل تسجيل دخول → auth/login
      emit(SplashToAuth());
    } else {
      // عامل تسجيل دخول → home
      emit(SplashToHome());
    }
  }
}

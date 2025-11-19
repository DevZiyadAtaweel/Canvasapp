import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(AuthLoading());

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(fullName);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? "حدث خطأ غير متوقع"));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? "فشل تسجيل الدخول"));
    } catch (e) {
      emit(AuthFailure(message: "حدث خطأ غير متوقع"));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(AuthPasswordResetEmailSent());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? "حدث خطأ غير متوقع"));
    } catch (e) {
      emit(AuthFailure(message: "حدث خطأ غير متوقع"));
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);
  Future<void> signInWithGoogle() async {
    emit(GmailAuthLoading());

    try {
      // تشغيل نافذة تسجيل الدخول بحساب جوجل
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // المستخدم لغى تسجيل الدخول
      if (googleUser == null) {
        emit(AuthFailure(message: "تم إلغاء تسجيل الدخول باستخدام جوجل"));
        return;
      }

      // جلب بيانات التوكن من حساب جوجل
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // إنشاء كريدينشال خاص بـ Firebase من بيانات جوجل
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // تسجيل الدخول في Firebase
      await _auth.signInWithCredential(credential);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? "فشل تسجيل الدخول باستخدام جوجل"));
    } catch (e) {
      emit(AuthFailure(message: "حدث خطأ غير متوقع أثناء تسجيل الدخول بجوجل"));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(message: "حدث خطأ غير متوقع"));
    }
  }
}

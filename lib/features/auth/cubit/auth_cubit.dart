import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------- دالة بناء رابط الصورة ----------
  String _buildAvatarUrl(String name) {
    final encodedName = Uri.encodeComponent(name);
    return 'https://ui-avatars.com/api/?name=$encodedName&background=random&size=512';
  }

  // ---------- دالة المزامنة مع Firestore ----------
  Future<void> _syncUserAfterLogin({String? providedName}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final uid = user.uid;
    final email = user.email ?? '';

    String name =
        providedName ??
        user.displayName ??
        (email.contains('@') ? email.split('@')[0] : 'بدون اسم');

    final userDocRef = _firestore.collection('users').doc(uid);
    final userDoc = await userDocRef.get();

    if (!userDoc.exists) {
      final avatarUrl = _buildAvatarUrl(name);

      await userDocRef.set({
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await userDocRef.update({'updatedAt': FieldValue.serverTimestamp()});
    }
  }

  // ---------- register ----------
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

      // هنا نكتب البيانات في Firestore لأول مرة
      await _syncUserAfterLogin(providedName: fullName);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? "حدث خطأ غير متوقع"));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  // ---------- login ----------
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // مزامنة بيانات المستخدم (لو أول مرة يدخل من جهاز جديد مثلاً)
      await _syncUserAfterLogin();

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? "فشل تسجيل الدخول"));
    } catch (e) {
      emit(AuthFailure(message: "حدث خطأ غير متوقع"));
    }
  }

  // ---------- reset password ----------
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

  // ---------- Google Sign In ----------
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

  Future<void> signInWithGoogle() async {
    emit(GmailAuthLoading());

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthFailure(message: "تم إلغاء تسجيل الدخول باستخدام جوجل"));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      // نستخدم displayName الجاي من جوجل (لو موجود)
      final displayName = userCredential.user?.displayName;

      await _syncUserAfterLogin(providedName: displayName);

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

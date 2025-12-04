import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:moftahak/core/services/supabase_storage_service.dart';

part 'add_child_state.dart';

class AddChildCubit extends Cubit<AddChildState> {
  AddChildCubit() : super(AddChildInitial());

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> addChild({
    required String name,
    required DateTime birthDate,
    required String gender,
    required String location,
    required String healthStatus,
    required String drawingHand,
    File? photoFile, // 👈 مو File photoUrl ، وبتقدر تكون null
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(AddChildFailure("المستخدم غير مسجل دخول"));
      return;
    }

    emit(AddChildLoading());

    try {
      // نولّد docRef أولاً عشان childId
      final childrenRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('children');

      final docRef = childrenRef.doc(); // يولّد childId تلقائيًا

      String photoUrl = "";

      // لو المستخدم اختار صورة، نرفعها على Supabase أولاً
      if (photoFile != null) {
        photoUrl = await SupabaseStorageService.uploadChildImage(
          file: photoFile,
          userId: user.uid,
          childId: docRef.id,
        );
      }

      // بعدين نحفظ بيانات الطفل في Firestore
      await docRef.set({
        'name': name,
        'birthDate': Timestamp.fromDate(birthDate),
        'gender': gender,
        'location': location,
        'healthStatus': healthStatus,
        'drawingHand': drawingHand,
        'photoUrl': photoUrl, // 👈 String URL، مش File
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      emit(AddChildSuccess());
    } catch (e) {
      print('AddChild error: $e');
      emit(AddChildFailure("فشل في إضافة الإبن، حاول مرة أخرى"));
    }
  }
}

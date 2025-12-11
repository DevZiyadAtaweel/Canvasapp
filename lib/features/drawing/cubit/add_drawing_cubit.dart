import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:moftahak/core/services/supabase_storage_service.dart';

part 'add_drawing_state.dart';

class AddDrawingCubit extends Cubit<AddDrawingState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AddDrawingCubit(
      this._firestore,
      this._auth) : super(AddDrawingInitial());

  Future<void> addDrawing({
    required File drawingFile,
    required String childId,
    Map<String, dynamic>? analysis,
  }) async {
    emit(AddDrawingLoading());

    try {
      final userId = _auth.currentUser!.uid;

      // 1) نجهز doc جديد للرسمة في:
      // users/{userId}/children/{childId}/drawings/{drawingId}
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('children')
          .doc(childId)
          .collection('drawings')
          .doc();

      final drawingId = docRef.id;

      // 2) نرفع صورة الرسمة على Supabase
      final drawingUrl = await SupabaseStorageService.uploadChildDrawingImage(
        file: drawingFile,
        userId: userId,
        childId: childId,
        drawingId: drawingId,
      );

      // 3) نخزّن بيانات الرسمة في Firestore
      await docRef.set({
        'drawingUrl': drawingUrl,
        'analysisStatus': analysis == null ? 'pending' : 'done',
        'analysisResult': analysis,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(AddDrawingSuccess());
    } catch (e) {
      print('AddDrawing error: $e');
      emit(AddDrawingFailure("فشل في إضافة الرسمة، حاول مرة أخرى"));
    }
  }
}

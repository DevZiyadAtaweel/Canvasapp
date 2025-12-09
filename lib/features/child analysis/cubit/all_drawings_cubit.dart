import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:moftahak/features/child%20analysis/model/all_drawings_model.dart';

part 'all_drawings_state.dart';

class AllDrawingsCubit extends Cubit<AllDrawingsState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AllDrawingsCubit(this._firestore, this._auth) : super(AllDrawingsInitial());

  Future<void> loadChildDrawings(String childId) async {
    emit(AllDrawingsLoading());

    try {
      final userId = _auth.currentUser!.uid;

      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('children')
          .doc(childId)
          .collection('drawings')
          .orderBy('createdAt', descending: true)
          .get();

      final drawings = snapshot.docs
          .map((doc) => AllDrawingsModel.fromDoc(doc.id, doc.data()))
          .toList();

      emit(AllDrawingsLoaded(drawings));
    } catch (e) {
      emit(AllDrawingsError('فشل في تحميل الرسومات: $e'));
    }
  }
}

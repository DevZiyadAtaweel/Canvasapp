import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:moftahak/features/home/model/child_model.dart';

part 'child_details_state.dart';

class ChildDetailsCubit extends Cubit<ChildDetailsState> {
  ChildDetailsCubit() : super(ChildDetailsInitial());
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<void> loadChild(String childId) async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(ChildDetailsError("المستخدم غير مسجل دخول"));
      return;
    }
    emit(ChildDetailsLoading());
    try {
      final docRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('children')
          .doc(childId);
      final snapshot = await docRef.get();

      if (!snapshot.exists) {
        emit(ChildDetailsError("بيانات الطفل غير موجودة"));
        return;
      }
      final data = snapshot.data() as Map<String, dynamic>;
      final child = ChildModel.fromMap(snapshot.id, data);

      emit(ChildDetailsLoaded(child));
    } catch (e) {
      emit(ChildDetailsError("حدث خطأ أثناء تحميل بيانات الطفل"));
    }
  }

  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}

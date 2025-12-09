import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moftahak/features/home/model/child_model.dart';
import 'package:moftahak/features/home/model/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  StreamSubscription<DocumentSnapshot>? _userSub;
  StreamSubscription<QuerySnapshot>? _childrenSub;
  UserModel? _currentUser;
  List<ChildModel> _children = [];
  String? _selectedChildId;
  void startUserListener() {
    _userSub?.cancel();
    _childrenSub?.cancel();

    final user = _auth.currentUser;
    if (user == null) {
      emit(HomeError("لا يوجد مستخدم مسجل دخول"));
      return;
    }

    emit(HomeLoading());

    final docRef = _firestore.collection('users').doc(user.uid);

    _userSub = docRef.snapshots().listen(
      (snapshot) {
        if (!snapshot.exists) {
          print("User document does not exist for UID: ${user.uid}");
          emit(HomeError("بيانات المستخدم غير موجودة"));
          return;
        }

        final data = snapshot.data() as Map<String, dynamic>;
        _currentUser = UserModel.fromMap(data, snapshot.id);

        _emitSuccess();
      },
      onError: (error) {
        emit(HomeError("فشل في جلب بيانات المستخدم"));
      },
    );
    _childrenSub = docRef
        .collection('children')
        .orderBy('name')
        .snapshots()
        .listen(
          (snapshot) {
            _children = snapshot.docs
                .map((doc) => ChildModel.fromMap(doc.id, doc.data()))
                .toList();
            if (_children.isNotEmpty && _selectedChildId == null) {
              _selectedChildId = _children.first.id;
            } else if (_children.isEmpty) {
              _selectedChildId = null;
            }
            _emitSuccess();
          },
          onError: (error) {
            print("فشل في جلب بيانات الأطفال: $error");

            if (_currentUser != null) {
              emit(
                HomeSuccess(
                  user: _currentUser!,
                  children: _children,
                  selectedChildId: _selectedChildId,
                ),
              );
            }
          },
        );
  }

  void _emitSuccess() {
    if (_currentUser == null) return;
    emit(
      HomeSuccess(
        user: _currentUser!,
        children: _children,
        selectedChildId: _selectedChildId,
      ),
    );
  }

  void selectChild(String childId) {
    _selectedChildId = childId;
    _emitSuccess();
  }

  String getFirstName(String fullName) {
    if (fullName.trim().isEmpty) return '';

    final parts = fullName.trim().split(' ');

    // يرجع أول جزء مش فاضي (لو في مسافات زيادة)
    return parts.firstWhere((p) => p.trim().isNotEmpty, orElse: () => '');
  }

  String getLastName(String fullName) {
    if (fullName.trim().isEmpty) return '';

    final parts = fullName.trim().split(' ');

    // يرجع آخر جزء مش فاضي (لو في مسافات زيادة)
    return parts.lastWhere((p) => p.trim().isNotEmpty, orElse: () => '');
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    _childrenSub?.cancel();
    return super.close();
  }
}

// lib/services/firebase_service.dart
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveDrawing({
    required String childId,
    required Uint8List imageBytes,
    required Map<String, dynamic> analysisResults,
  }) async {
    // 1. رفع الصورة إلى Storage
    String fileName = '${DateTime.now().millisecondsSinceEpoch}_drawing.jpg';
    Reference storageRef = _storage.ref().child('child_drawings/$childId/$fileName');

    UploadTask uploadTask = storageRef.putData(
      imageBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    // 2. حفظ البيانات في Firestore
    Map<String, dynamic> firestoreData = {
      'childId': childId,
      'imageUrl': downloadUrl,
      'aiResult': analysisResults,
      'uploadedAt': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('Drawings').add(firestoreData);
  }
}
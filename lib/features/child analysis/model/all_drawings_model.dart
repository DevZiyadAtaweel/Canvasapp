import 'package:cloud_firestore/cloud_firestore.dart';

class AllDrawingsModel {
  final String drawingId;
  final String drawingUrl;
  final String? emotion;
  final String? description;
  final String analysisStatus;
  final DateTime? createdAt;

  AllDrawingsModel({
    required this.drawingId,
    required this.drawingUrl,
    this.emotion,
    this.description,
    required this.analysisStatus,
    this.createdAt,
  });

  factory AllDrawingsModel.fromDoc(String id, Map<String, dynamic> data) {
    final analysis = data['analysisResult'] as Map<String, dynamic>?;

    return AllDrawingsModel(
      drawingId: id,
      drawingUrl: data['drawingUrl'] ?? '',
      analysisStatus: data['analysisStatus'] ?? 'pending',
      emotion: analysis?['emotion'],
      description: analysis?['description'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

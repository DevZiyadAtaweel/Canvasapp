import 'package:cloud_firestore/cloud_firestore.dart';

class ChildModel {
  final String id;
  final String name;
  final DateTime? birthDate;
  final String gender;
  final String location;
  final String healthStatus;
  final String drawingHand;
  final String photoUrl;

  ChildModel({
    required this.id,
    required this.name,
    this.birthDate,
    required this.gender,
    required this.location,
    required this.healthStatus,
    required this.drawingHand,
    required this.photoUrl,
  });

  factory ChildModel.fromMap(String id, Map<String, dynamic> data) {
    return ChildModel(
      id: id,
      name: data['name'] ?? '',
      birthDate: (data['birthDate'] != null)
          ? (data['birthDate'] as Timestamp).toDate()
          : null,
      gender: data['gender'] ?? '',
      location: data['location'] ?? '',
      healthStatus: data['healthStatus'] ?? '',
      drawingHand: data['drawingHand'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }
}

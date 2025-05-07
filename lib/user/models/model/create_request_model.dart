import 'package:cloud_firestore/cloud_firestore.dart';

class UserCreateRequestModel {
  final String userName;
  final String userEmail;
  final String phone;
  final String location;
  final List<String> specializations;
  final String? description;
  final String status;
  final DateTime? timestamp;

  UserCreateRequestModel({
    required this.userName,
    required this.userEmail,
    required this.phone,
    required this.location,
    required this.specializations,
    this.description,
    this.status = 'Pending',
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'phone': phone,
      'location': location,
      'specializations': specializations,
      'description': description ?? '',
      'status': status,
      'timestamp': timestamp ?? DateTime.now(),
    };
  }

  factory UserCreateRequestModel.fromMap(Map<String, dynamic> map) {
    return UserCreateRequestModel(
      userName: map['userName'],
      userEmail: map['userEmail'],
      phone: map['phone'],
      location: map['location'],
      specializations: List<String>.from(map['specializations']),
      description: map['description'],
      status: map['status'] ?? 'Pending',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate(),
    );
  }
}

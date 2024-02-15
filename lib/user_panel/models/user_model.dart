import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String mail;
  final String contactNumber;
  final String password;
  final List<String> bookedRooms; // New field

  UserModel({
    required this.userId,
    required this.name,
    required this.mail,
    required this.contactNumber,
    required this.password,
    required this.bookedRooms, // New field
  });

  factory UserModel.fromJson(DocumentSnapshot json) {
    return UserModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      mail: json['mail'] as String,
      contactNumber: json['contactNumber'] as String,
      password: json['password'] as String,
      bookedRooms: List<String>.from(json['bookedRooms'] ?? []), // Parse the list from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'mail': mail,
      'contactNumber': contactNumber,
      'password': password,
      'bookedRooms': bookedRooms, // Add the list to JSON
    };
  }
}

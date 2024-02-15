import 'package:cloud_firestore/cloud_firestore.dart';

class RoomsDetails {
  final int totalRoom;
  final int bookedRoom;
  final int availableRoom;

  final List<String> bookedUsers;

  RoomsDetails({
    required this.totalRoom,
    required this.bookedRoom,
    required this.availableRoom,
    required this.bookedUsers,
  });

  // Convert RoomModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalRoom': totalRoom,
      'bookedRoom': bookedRoom,
      'availableRoom': availableRoom,
      'bookedUsers': bookedUsers,
    };
  }

  // Create RoomModel from JSON
  factory RoomsDetails.fromJson(DocumentSnapshot json) {
    return RoomsDetails(
      totalRoom: json['totalRoom'],
      bookedRoom: json['bookedRoom'],
      availableRoom: json['availableRoom'],
      bookedUsers: List<String>.from(json['bookedUsers']),
    );
  }
}
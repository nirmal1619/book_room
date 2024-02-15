import 'package:cloud_firestore/cloud_firestore.dart';

class NewRoom {
  final int roomNumber;
  final Timestamp? checkIn; // Make checkIn nullable
  final Timestamp? checkOut; // Make checkOut nullable
  final bool isBooked;
  final bool isACRoom;
  final int price;
  final String bookedBy;
  final String roomDescription;
  final String contactNo; // New field
  final String mailId; // New field

  NewRoom({
    required this.roomNumber,
    this.checkIn,
    this.checkOut,
    required this.isBooked,
    required this.isACRoom,
    required this.price,
    required this.bookedBy,
    required this.roomDescription,
    required this.contactNo,
    required this.mailId,
  });

  factory NewRoom.fromJson(DocumentSnapshot snap) {
    return NewRoom(
      roomNumber: snap['roomNumber'] ?? 0,
      checkIn: snap['checkIn'] ?? null,
      checkOut: snap['checkOut'] ?? null,
      isBooked: snap['isBooked'] ?? false,
      isACRoom: snap['isACRoom'] ?? false,
      price: snap['price'] ?? 0,
      bookedBy: snap['bookedBy'] ?? '',
      roomDescription: snap['roomDescription'] ?? '',
      contactNo: snap['contactNo'] ?? '',
      mailId: snap['mailId'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'roomNumber': roomNumber,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'isBooked': isBooked,
      'isACRoom': isACRoom,
      'price': price,
      'bookedBy': bookedBy,
      'roomDescription': roomDescription,
      'contactNo': contactNo,
      'mailId': mailId,
    };
  }
}

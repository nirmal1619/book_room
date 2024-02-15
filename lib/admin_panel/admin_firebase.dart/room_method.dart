import 'package:book_room/admin_panel/room%20model/new_room_model.dart';
import 'package:book_room/admin_panel/room%20model/rooms_details_model.dart';
import 'package:book_room/user_panel/users_firebase.dart/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../user_panel/models/user_model.dart';

class RoomMethod {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

 
  Future<void> CreateDataBase() async {
    try {
      RoomsDetails model = RoomsDetails(
        totalRoom: 0,
        bookedRoom: 0,
        availableRoom: 0,
        bookedUsers: [],
      );
      await _firebaseFirestore
          .collection("RoomsDataBase")
          .doc("details")
          .set(model.toJson());

    } catch (e) {

      debugPrint("error in roomdetail $e");

    }
  }

  Future<void> bookRoom(bool ac,int roomNo,DateTime checkIn,DateTime checkOut,bool isAdmin)
   async {
    try {
      String uid='Admin';
      if(!isAdmin){
       uid= FirebaseAuth.instance.currentUser!.uid;
      }

      DocumentReference ref=_firebaseFirestore
                            .collection("RoomsDataBase")
                            .doc("details");

      RoomsDetails roomDetail = await roomsDetails();

      ref.update({

      "availableRoom" : roomDetail.availableRoom-1,
      "bookedRoom" : roomDetail.bookedRoom+1,
      "bookedUsers": FieldValue.arrayUnion([uid])

      });
      if(isAdmin){
         await  _firebaseFirestore.collection("Rooms").doc("Room no ${roomNo}")
          .update(
          {
              "bookedBy" : "Admin",
              "contactNo" :"AdminNo",
              "mailId": "admin@1619@gmail.com",
              "checkIn" : Timestamp.fromDate(checkIn),
              "checkOut" : Timestamp.fromDate(checkOut),
              "isBooked": true,

      }
      );
      }
     else {
        UserModel user = await FirebaseAuthClass().getUserDetails(uid);
        await _firebaseFirestore.collection("Rooms").doc("Room no ${roomNo}")
            .update(
            {
              "bookedBy": user.name,
              "contactNo": user.contactNumber,
              "mailId": user.mail,
              "checkIn": Timestamp.fromDate(checkIn),
              "checkOut": Timestamp.fromDate(checkOut),
              "isBooked": true,

            }

        );
       await _firebaseFirestore.collection("users").doc(uid).update({
        "bookedRooms"  : FieldValue.arrayUnion(["Room no $roomNo"])
       });
      }
      


    } catch (e) {
    debugPrint("error in book room function error=> $e");
    }
  }

  Future<RoomsDetails> roomsDetails()async{

   final FirebaseFirestore firestore=FirebaseFirestore.instance;

   RoomsDetails tempRoomDetail=RoomsDetails(totalRoom: 0, bookedRoom: 0, availableRoom: 0, bookedUsers: []);
    
    try{

     DocumentSnapshot snap = await firestore
                            .collection("RoomsDataBase")
                            .doc("details").get();

      tempRoomDetail =  RoomsDetails.fromJson(snap);
      return tempRoomDetail;

    }
    catch(e){
      debugPrint("error in init room details function error=> $e");
      return tempRoomDetail;
    }
  }

  Future<void> addroom(bool ACRoom,int price,String roomDescription)async{
    
    try{
     RoomsDetails roomDetail=await roomsDetails();
     
     NewRoom newRoom= NewRoom(
        mailId: "",
        contactNo: "",
         checkIn: null,
         checkOut: null,
         roomDescription: roomDescription,
         roomNumber: roomDetail.totalRoom+1,
         isBooked: false, 
         isACRoom: ACRoom, 
         price: price,
         bookedBy: ""
     );
     await  _firebaseFirestore.collection("Rooms")
                              .doc("Room no ${roomDetail.totalRoom+1}")
                              .set(newRoom.toJson());

     DocumentReference ref=_firebaseFirestore
                            .collection("RoomsDataBase")
                            .doc("details");

    await ref.update({
                      "availableRoom" : roomDetail.availableRoom+1,
                      "totalRoom" : roomDetail.totalRoom+1,
    });

    }
    catch(e){
      debugPrint("error in addroom function error=>$e");
    }
  }



}
  

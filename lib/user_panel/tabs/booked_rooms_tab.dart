import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../users_firebase.dart/auth.dart';

class BookedRoomTab extends StatefulWidget {
  @override
  State<BookedRoomTab> createState() => _BookedRoomTabState();
}

class _BookedRoomTabState extends State<BookedRoomTab> {
  UserModel user = UserModel(
    userId: "",
    name: "",
    mail: "",
    contactNumber: "",
    password: "",
    bookedRooms: [],
  );

  Future<void> getYourRoomsList() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
     UserModel  _user = await FirebaseAuthClass().getUserDetails(uid);
      setState(() {
        print("$_user");
        user=_user;
      });
    } catch (e) {
      debugPrint("error in getYourroomList method => $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getYourRoomsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        user.bookedRooms != null ?
           Expanded(
            child: ListView.builder(
              itemCount: user.bookedRooms.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(user.bookedRooms[index]),
                    // subtitle: Text(),
                  ),
                );
              },
            ),
          ):
    Text("no ata"),



      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInUserList extends StatefulWidget {
  const SignInUserList({super.key});

  @override
  State<SignInUserList> createState() => _SignInUserListState();
}

class _SignInUserListState extends State<SignInUserList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("users").get(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting) {
            return Center(

              child: CircularProgressIndicator(),
            );
          }
            else if(snapshot.hasData){
              List<QueryDocumentSnapshot> userList=snapshot.data!.docs;
              print("userlist=> ${userList[0]["name"]}");
              return ListView.builder(
                itemCount: userList.length,
                  itemBuilder: (context,index){
                  return Card(
                    child: ListTile(
                      title: Text(userList[index]["name"]),
                      subtitle: Text("mail ${userList[index]["mail"]} no- ${userList[index]["contactNumber"]}"),
                    ),
                  );
                  }
              );
          }
            else{
              return Center(
                child: Text("no data"),
              );
          }

        }
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomsListTab extends StatelessWidget {
  const RoomsListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("Rooms").get(),
              builder: (context,snapshot) {
                if(snapshot.hasData){
                List<QueryDocumentSnapshot> list= snapshot.data!.docs;

                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context,index){
                        Timestamp? checkIn = list[index]["checkIn"];
                        Timestamp? checkOut = list[index]["checkOut"];

                        DateTime? checkInDate = checkIn != null ? checkIn.toDate() : null;
                        DateTime? checkOutDate = checkOut != null ? checkOut.toDate() : null;

                        return Card(
                          child: ListTile(
                            title: Text("Room no ${index + 1}"),
                            trailing:(list[index]["bookedBy"]).toString().length> 1 ?
                            Text("booked by ${list[index]["bookedBy"]}"):
                                Text(""),
                            subtitle: checkInDate != null && checkOutDate != null
                                ? Text("booked from $checkInDate to $checkOutDate")
                                : Text("Room not booked yet"),
                          ),
                        );

                      }
                  );
                }
                else if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else{
                  return Center(child: Text("no data"),);
                }
              }
          ),

        ),
      ],
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../admin_panel/admin_firebase.dart/room_method.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  final TextEditingController _totalMembers=TextEditingController();

  DateTime  ? checkInDate;
  DateTime ?  checkOutDate;


  Future<void> getDates() async {
    try {

      checkInDate = await selectDate("select check in date");
      checkOutDate = await selectDate("select check out date");
    } catch (e) {
      print(e);
    }
  }

  Future<DateTime?> selectDate(String message) async {
    DateTime? selectedDate;
    try {
      selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        helpText: message,
      );
    } catch (e) {
      print(e);
    }
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        FutureBuilder(
          future: FirebaseFirestore.instance.collection("Rooms").get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> roomList = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  itemCount: roomList.length,
                  itemBuilder: (context, index) {
                    bool isBooked = roomList[index]["isBooked"];
                    bool isACRoom = roomList[index]["isACRoom"];
                    String roomType = isACRoom ? "AC" : "non-AC";
                    var roomData=roomList[index];
                    if (isBooked) {
                      return SizedBox.shrink();
                    }

                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Room no ${roomData["roomNumber"]}"),
                            Text(
                              "  (${roomType})",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${roomData["roomDescription"]}"),
                            Text("price ${roomData["price"]}")
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            await getDates();
                            print("check in data ${checkInDate} check out data ${checkOutDate}");

                            if(checkOutDate !=null && checkInDate !=null){
                              print("should show container");
                              await showBottomSheetContainer(context,roomList,index);
                            }

                            // bookRoom(context);

                          },
                          child: Text("Book Room"),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text("No Room available"),
              );
            }
          },
        )
      ],
    );
  }

  Widget TextFiledContainer(){
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          shape: BoxShape.rectangle,
          border: Border.all(
              color: Colors.grey.shade300
          )

      ),
      child: Padding(
        padding: const EdgeInsets
            .only(bottom: 0),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: _totalMembers,

          decoration: InputDecoration(

              hintText: "Total members are",
              hintStyle: const TextStyle(
                  color: Colors.black

              ),

              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 6,top: 0),
                child: Icon(
                  Icons.people,
                  color: Colors.grey.shade700,
                ),

              )
          ),
        ),
      ),
    );
  }
  Future showBottomSheetContainer(BuildContext context,List<QueryDocumentSnapshot> roomList ,int index ) async {

    await showModalBottomSheet(
      isDismissible: false,
      context: context,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (context) => Container(
        width: double.infinity,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Book Room",
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextFiledContainer(),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Text("Check in Date"),
                        Text("${checkInDate!.day}/${checkInDate!.month}/${checkInDate!.year}"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(

                    child: Column(
                      children: [
                        Text("Check out Date"),
                        Text("${checkOutDate!.day}/${checkOutDate!.month}/${checkOutDate!.year}"),
                      ],
                    ),
                  ),
                )
              ],
            ),

            // Text(_date!.day.toString())
            ElevatedButton(

              onPressed: ()async{
                Navigator.pop(context);
                if(_totalMembers.text!=null){
                  int members=int.parse(_totalMembers.text);
                  int value= ((members/2).toInt() + (members%2 ).toInt());

                  for(int i=0; i<value; i++){
                    await RoomMethod().
                    bookRoom(
                        false,roomList[index+i]["roomNumber"],
                        checkInDate!,
                        checkOutDate!,
                        false
                    );

                  }

                }

              }, child:Text("book now"),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:book_room/admin_panel/admin_firebase.dart/room_method.dart';
import 'package:book_room/admin_panel/room%20model/rooms_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../text_filed_container.dart';



class RoomsOverviewTab extends StatefulWidget {


  const RoomsOverviewTab({Key? key}) : super(key: key);

  @override
  State<RoomsOverviewTab> createState() => _RoomsOverviewTabState();
}

class _RoomsOverviewTabState extends State<RoomsOverviewTab> {

  RoomsDetails  roomModel=RoomsDetails(totalRoom: 0, bookedRoom: 0, availableRoom: 0, bookedUsers: []);

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


  Future<void> roomsDetails()async{
    RoomsDetails tempRoomModel=await RoomMethod().roomsDetails();

    setState(() {
      roomModel=tempRoomModel;
    });

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomsDetails();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
      
            child: Card(
              child: ListTile(
                title: Text("Total Rooms ${roomModel.totalRoom}"
                  ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                subtitle: Text("Nmae of rooms - 1,2 ,3"),
              ),
            ),
          ),
          // const Divider(),
      
          Container(
            height: 200,
            child: Card(
              child: ListTile(
                title: Text("Available Rooms ${roomModel.availableRoom}"
                  ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                subtitle: Text("available are 1 2"),
              ),
            ),
          ),
          // const Divider(),
          Container(
            height: 200,
            child: Card(
              child: ListTile(
                title: Text("Booked Rooms ${roomModel.bookedRoom} "
                  ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                subtitle: Text("booked rooms are 23, 4 ,5 "),
              ),
            ),
          ),
          const Divider(),
          SizedBox(height: 20),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             ElevatedButton(
               onPressed: () async {

                 await RoomMethod();

               },
               child: Text("Book Room"),
             ),
             ElevatedButton(
               onPressed: () async {
                 // roomModel.
                 // showBottomSheetContainer(
                 //     context,
                 //     roomList,
                 //     index
                 // )
                 await addRoom(context);

                // await RoomDetails().addroom(false, 2000,);

               },
               child: Text("Add Room"),
             ),
             ElevatedButton(
               onPressed: () async {
      
                 await RoomMethod().CreateDataBase();
      
               },
               child: Text("database"),
             ),
      
           ],
         )
        ],
      ),
    );
  }
  Future<void> addRoom(BuildContext context) async {
    TextEditingController roomDescriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController roomsQuantity = TextEditingController();

    bool isACRoom = false;


    await showModalBottomSheet(
      isDismissible: false,
      context: context,
      backgroundColor: Colors.white,
     
      builder: (context) => Container(
        width: double.infinity,
        height: 1000,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Book room",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ContainerTextField(
                iconData: Icons.edit,
                hintText: 'Room Description',
                controller: roomDescriptionController,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ContainerTextField(
                      iconData: Icons.currency_rupee,
                    
                      hintText: 'Price',
                      controller: priceController,
                    ),
                  ),

                  Expanded(
                    child: ContainerTextField(
                      iconData: Icons.house,
                    
                      hintText: "Add Rooms",
                      controller: roomsQuantity,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async{
                  Navigator.pop(context);

                  for(int i=0; i<int.parse(roomsQuantity.text); i++){
                    await RoomMethod().addroom(
                        isACRoom,
                        int.parse(priceController.text) ,
                        roomDescriptionController.text
                    );   await roomsDetails();
                  }


                },
                child: Text('Add Room'),
              ),
            ],
          ),
        ),
      ),
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




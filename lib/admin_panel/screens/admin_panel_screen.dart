import 'package:book_room/admin_panel/tabs/rooms_list.dart';
import 'package:book_room/admin_panel/tabs/rooms_overview.dart';
import 'package:book_room/admin_panel/tabs/signIn_user_list.dart';
import 'package:flutter/material.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
   


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   

  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // floatingActionButton: Container(color: Colors.black,height: 20,width: 20,),
        appBar: AppBar(
         
          title: const Text("Admin Panel"),
          bottom:const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
           Tab(
                icon: Icon(Icons.list),
              ),

              Tab(
                icon: Icon(Icons.person_2_sharp),
              ),
            Tab(
              icon: Icon(Icons.add),
            ),
          ]
          ), 
        ),
         body:  SafeArea(
      child: TabBarView(
      children: [
         RoomsOverviewTab(),

        RoomsListTab(),

       SignInUserList(),

                    // Third Tab (Person icon) content
                    Container(
                      alignment: Alignment.center,
                      child: const Text("Person Icon Content"),
                    ),
       
      ],
      ),
         ),
      ),
    );
  }
}
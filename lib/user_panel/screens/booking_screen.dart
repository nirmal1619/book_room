

import 'package:book_room/user_panel/users_firebase.dart/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../admin_panel/admin_firebase.dart/room_method.dart';
import '../../constants/color_value.dart';
import '../tabs/booked_rooms_tab.dart';
import '../tabs/booking_tab.dart';

// Assume you have the necessary imports for RoomMethod and ColorValue

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      appBar: AppBar(
        title: const Text("Book room"),
        actions: [
          TextButton(
            onPressed: () async {
             await FirebaseAuthClass().SignOut();
            },
            child: Text("Date"),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Book Room"),
            Tab(text: "Booked Room"),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            BookingTab(),
            BookedRoomTab(),
          ],
        ),
      ),
    );
  }
}


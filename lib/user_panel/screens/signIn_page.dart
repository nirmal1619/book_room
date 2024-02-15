
import 'package:book_room/constants/color_value.dart';
import 'package:flutter/material.dart';

import '../users_firebase.dart/auth.dart';
import '../users_firebase.dart/firebase_database.dart';
import 'booking_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

final TextEditingController _email =TextEditingController();
final TextEditingController _password =TextEditingController();
final TextEditingController _name =TextEditingController();
final TextEditingController _contactNumber =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValue.backgroundColor,
      appBar: AppBar(
        title: const Text("SignIn"),
    
      ),
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.all(8.0).copyWith(top: 100),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
                Container(
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
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    controller: _name,
                  
                    decoration: InputDecoration(
                     hintText: "Enter name",
                     hintStyle: const TextStyle(
                      color: Colors.black
                     ),
                      
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 6,top: 0),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey.shade700,
                        ),
                     
                      )
                    ),
                  ),
                ),
               ),
               const SizedBox(height: 15,),
                Container(
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
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    controller: _email,
                  
                    decoration: InputDecoration(
                     hintText: "enter mail",
                     hintStyle: const TextStyle(
                      color: Colors.black
                     ),
                      
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 6,top: 0),
                        child: Icon(
                          Icons.mail,
                          color: Colors.grey.shade700,
                        ),
                     
                      )
                    ),
                  ),
                ),
               ),
               const SizedBox(height: 15,),
                Container(
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
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    controller: _contactNumber,
                  
                    decoration: InputDecoration(
                     hintText: "contact number",
                     hintStyle: const TextStyle(
                      color: Colors.black
                     ),
                      
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 6,top: 0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.grey.shade700,
                        ),
                     
                      )
                    ),
                  ),
                ),
               ),
               const SizedBox(height: 15,),

               Container(
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
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    controller: _password,
                  
                    decoration: InputDecoration(
                     hintText: "password",
                     hintStyle: const TextStyle(
                      color: Colors.black
                     ),
                      
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 6,top: 0),
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey.shade700,
                        ),
                     
                      )
                    ),
                  ),
                ),
               ),

               const SizedBox(
                height: 15,
               ),
               Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.black
                  )

                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      
                     
                    overlayColor: MaterialStateColor.
                    resolveWith((states) => Colors.white),
                    
                    backgroundColor: MaterialStateColor
                    .resolveWith((states) => 
                    const Color.fromARGB(255, 255, 255, 255)),
                    
                    
                    foregroundColor: MaterialStateColor
                    .resolveWith((states) => Colors.black),

                      textStyle: const MaterialStatePropertyAll<TextStyle>(
                        TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold

                      )
                      )
                  ),
                  onPressed: ()async{
                   
                   String result= await FirebaseAuthClass()

                    .createAccount
                    (
                      _email.text,
                    _password.text


                    );
                    if(result=="successful"){
                     await DataBaseClass().addUser(
                      _name.text,
                       _contactNumber.text,
                        _email.text,
                        _password.text
                        );
                    }
                    Navigator
                    .push(
                      context, MaterialPageRoute(
                      builder: (_)=>BookingScreen()
                      )
                      );
                  }, 
                  child: const Text(
                    "Create Account",
                    
                  ),
                  ),
                ),
               const SizedBox(
                height: 20,
               ),
               
            ],
          ),
        ),
      ),
    );
  }
}
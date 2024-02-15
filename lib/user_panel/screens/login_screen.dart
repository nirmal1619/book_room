import 'package:book_room/constants/color_value.dart';
import 'package:book_room/user_panel/screens/signIn_page.dart';
import 'package:flutter/material.dart';

import '../users_firebase.dart/auth.dart';
import 'booking_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

final TextEditingController _email =TextEditingController();
final TextEditingController _password =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorValue.backgroundColor,
      appBar: AppBar(
        title: const Text("user login"),

      ),
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.all(8.0),
          child:  Column(
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
                    controller: _password,
                  
                    decoration: InputDecoration(
                     hintText: "Enter password",
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
                height: 20,
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
                   bool res=await FirebaseAuthClass().logIn(
                    _email.text,
                   _password.text);
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BookingScreen()));
                  }, 
                  child: const Text(
                    "login",
                    
                  ),
                  ),
                ),
               const SizedBox(
                height: 20,
               ),
               TextButton(onPressed: ()=>Navigator.of(context).
               push(MaterialPageRoute(
                builder: (_)=>SignInScreen()
                )
                ), 
               style: TextButton.styleFrom(
                foregroundColor:Colors.black ,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                  
                )
               ),
               child: const Text("New user ? create an account ")
               )

                
            ],
          ),
        ),
      ),
    );
  }
}
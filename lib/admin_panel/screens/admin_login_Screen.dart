import 'package:book_room/admin_panel/admin_firebase.dart/admin_login.dart';
import 'package:book_room/admin_panel/screens/admin_panel_screen.dart';
import 'package:book_room/constants/color_value.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});

final TextEditingController _email =TextEditingController();
final TextEditingController _password =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorValue.backgroundColor,
      appBar: AppBar(
        title: const Text("Admin login"),

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
                   bool res=await AdminLoginMethod()
                   .AdminLogin(
                    _email.text,
                   _password.text);
                  if(res){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>
                    const AdminPanelScreen()
                    )
                    )
                    ;
                  }
                  }, 
                  child: const Text(
                    "login",
                    
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
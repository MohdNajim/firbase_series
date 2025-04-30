import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgerpasswardscreen extends StatefulWidget {
  const Forgerpasswardscreen({super.key});

  @override
  State<Forgerpasswardscreen> createState() => _ForgerpasswardscreenState();
}

class _ForgerpasswardscreenState extends State<Forgerpasswardscreen> {
  String? emailerror;
  final TextEditingController emailController=TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future<void> resetPassward()async{
    try{
      await _auth.sendPasswordResetEmail(email: emailController.text);
      Get.snackbar("Hi", "Sent to Email");
      Get.back();
    }catch(e){
      Get.snackbar('error', e.toString());
    }
  }

  void validateEmail(String value){
    String pattern= r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp=RegExp(pattern);
    setState(() {
      if(value.isEmpty){
        emailerror="Enter Your Email";
      }else if(!regExp.hasMatch(value)){
        emailerror="Invalid Email!";
      }else{
        emailerror=null;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green.shade300,
                  ),
                  child: Icon(Icons.arrow_back,color: Colors.white,),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text('Forgot Passward?',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500,letterSpacing: 1),),
            Text('We just need your registered email address to reset your passward',maxLines: 2,style: TextStyle(color: Colors.grey.shade700,fontSize: 17),),
            SizedBox(
              height: 60,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              onChanged: validateEmail,
              decoration: InputDecoration(
                errorText: emailerror,
                hintText: "Enter your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.green.shade700
                  )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.green.shade700
                    )
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: (){
                resetPassward();
              },
              child: Container(
                height: 55,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.green.shade700
                ),
                child: Center(
                  child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700,letterSpacing: 1),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

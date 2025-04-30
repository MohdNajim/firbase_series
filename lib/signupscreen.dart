import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/utils/colors.dart';
import 'package:firebase_series/wrapperscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {

  final FocusNode _focusNode=FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus=FocusNode();
  bool _isFilled=false;
  bool _ispasswardfilled=false;
  bool _confirmpassward=false;
  String? emailerror;

  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwardController=TextEditingController();
  final TextEditingController confirmPasswardController=TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;
  
  Future<void> signUpUser()async{
    if(passwardController.text!=confirmPasswardController.text){
     Get.snackbar("Invalid!", "Passward don\'t match");
      return;
    }
    try{
      await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwardController.text);
       Get.snackbar("Hi", "SignUp Successful!",snackStyle:SnackStyle.GROUNDED,backgroundColor: themeColor);
        Get.to(Wrapperscreen());
    }catch(e){
     Get.snackbar('Error', "Invalid parameters!",backgroundColor: Colors.redAccent,);
    }
  }


  void validateEmail(String value){
    String pattern=r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp=RegExp(pattern);
    setState(() {
      if(value.isEmpty){
        emailerror="Enter Your Email";
      }else if(!regExp.hasMatch(value)){
        emailerror="Invalid Email!";
      }else{
        emailerror =null;
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _focusNode.addListener((){
      setState(() {
        _isFilled=_focusNode.hasFocus;
      });
    });

    _passwordFocus.addListener((){
      setState(() {
        _ispasswardfilled=_passwordFocus.hasFocus;
      });
    });
    _confirmFocus.addListener((){
      setState(() {
        _confirmpassward=_confirmFocus.hasFocus;
      });
    });
  }

  void dispose(){
    _passwordFocus.dispose();
    _focusNode.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 650,
                ),
                Container(
                  height: 300,
                  width: double.maxFinite,
                  color: Colors.green.shade100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60,left: 20),
                    child: Text('Signup',style: TextStyle(color: Colors.green.shade500,fontSize: 24,fontWeight: FontWeight.w500,letterSpacing: 1),),
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 500,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20,
                                spreadRadius: 10
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text('Signup Form',style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold,letterSpacing: 1.5),),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: 0.8,color: Colors.grey)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Get.back();
                                      },
                                        child: Text('Login',style: TextStyle(color: Colors.green.shade300,fontWeight: FontWeight.bold,fontSize: 24),)),
                                    Text('Signup',style: TextStyle(color: Colors.green.shade300,fontWeight: FontWeight.bold,fontSize: 24),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              onChanged: validateEmail,
                              controller: emailController,
                              style: TextStyle(color: Colors.blueAccent.shade700,fontSize: 17,fontWeight: FontWeight.bold,letterSpacing: 1),
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                errorText: emailerror,
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(color: _isFilled?Colors.blueAccent.shade700:Colors.green.shade300,fontSize: 17,letterSpacing: 1
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700,
                                          width: 1.5,
                                          style: BorderStyle.solid
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.green.shade300
                                      )
                                  )
                              ),
                              onFieldSubmitted: (_){
                                FocusScope.of(context).requestFocus(_passwordFocus);
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              validator: (value){
                                if(value==null||value.isEmpty&&value.length<=8){
                                  return "Enter Your Passward!";
                                }
                              },
                              controller: passwardController,
                             focusNode: _passwordFocus,
                              style: TextStyle(color: Colors.blueAccent.shade700,fontSize: 17,fontWeight: FontWeight.bold,letterSpacing: 1),
                              decoration: InputDecoration(
                                  hintText: 'Passward',
                                  hintStyle: TextStyle(color: _ispasswardfilled?Colors.blueAccent.shade700:Colors.green.shade300,fontSize: 17,letterSpacing: 1
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700,
                                          width: 1.5,
                                          style: BorderStyle.solid
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.green.shade300
                                      )
                                  )
                              ),
                              onFieldSubmitted: (_){
                                 FocusScope.of(context).requestFocus(_confirmFocus);
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              controller: confirmPasswardController,
                              focusNode: _confirmFocus,
                              style: TextStyle(color: Colors.blueAccent.shade700,fontSize: 17,fontWeight: FontWeight.bold,letterSpacing: 1),
                              decoration: InputDecoration(
                                  hintText: 'Confirm Passward',
                                  hintStyle: TextStyle(color: _confirmpassward?Colors.blueAccent.shade700:Colors.green.shade300,fontSize: 17,letterSpacing: 1
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700,
                                          width: 1.5,
                                          style: BorderStyle.solid
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.green.shade300
                                      )
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),

                            GestureDetector(
                              onTap: (){
                                signUpUser();
                              },
                              child: Container(
                                height: 50,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text("SignUp",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/forgerpasswardscreen.dart';
import 'package:firebase_series/signupscreen.dart';
import 'package:firebase_series/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey=GlobalKey<FormState>();
  String ? emailerror;
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwardController=TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FocusNode _focusNode=FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _isFilled=false;
  bool _ispasswardfilled=false;

  Future<void> loginUser()async{
    try{
      await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwardController.text);
     Get.snackbar("Login Successful!","");
    }catch(e){
      if(_formKey.currentState!.validate()){
      }
      Get.snackbar("Invalid Parameters","");
    }
  }

  Future<void> signInGoogle()async{
    final GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    if(googleUser==null)
      return;
    final GoogleSignInAuthentication googleAuth=await googleUser.authentication;
    final credential=GoogleAuthProvider.credential(
      accessToken:googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
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
  }
  @override
  void dispose(){
    _passwordFocus.dispose();
    _focusNode.dispose();
    super.dispose();
  }


  void validateEmail(String value){
    String pattern=
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex=RegExp(pattern);
    setState(() {
      if(value.isEmpty){
        emailerror="Email is required!";
      }else if(!regex.hasMatch(value)){
        emailerror="Invalid Email Format!";
      }else{
        emailerror=null;
      }
    });
  }


  Future<void> signInAnonymously()async{
    try{
      await FirebaseAuth.instance.signInAnonymously();
    }catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                      child: Text('Login',style: TextStyle(color: Colors.green.shade500,fontSize: 24,fontWeight: FontWeight.w500,letterSpacing: 1),),
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
                              Text('Login Form',style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold,letterSpacing: 1.5),),
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
                                      Text('Login',style: TextStyle(color: Colors.green.shade300,fontWeight: FontWeight.bold,fontSize: 24),),
                                      GestureDetector(
                                        onTap: (){
                                            Get.to(Signupscreen());
                                        },
                                          child: Text('Signup',style: TextStyle(color: Colors.green.shade300,fontWeight: FontWeight.bold,fontSize: 24),)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
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
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value==null||value.isEmpty&&value.length<=8){
                                    return "Enter Your Passward";
                                  }return null;
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
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(Forgerpasswardscreen());
                                    },
                                      child: Text('Forgot password?',style: TextStyle(color: Colors.blueAccent,fontSize: 20,fontWeight: FontWeight.w500,),)),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              GestureDetector(
                                onTap: (){
                                  loginUser();
                                },
                                child: Container(
                                  height: 50,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(Signupscreen());
                                },
                                child: RichText(text: TextSpan(
                                  text: 'Not a member?',
                                  style: TextStyle(color: Colors.black,fontSize: 18,),
                                  children: [
                                    TextSpan(
                                      text: " Signup now",
                                      style: TextStyle(color: Colors.blueAccent.shade700,fontSize: 18)
                                    )
                                  ]
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
           GestureDetector(
             onTap: (){
               signInGoogle();
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 100),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     height: 65,
                     width: 65,
                     decoration: BoxDecoration(
                         color: Colors.green.shade50,
                       borderRadius: BorderRadius.circular(60),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black12,
                           blurRadius: 10,
                           spreadRadius: 5
                         )
                       ]
                     ),
                     child: Image.asset('assets/images/googleicon.png',height: 40,width: 40,fit: BoxFit.fill,)
                   ),

                   TextButton(onPressed: (){
                     signInAnonymously();
                   },
                 child:  Text('Login as guest',style: TextStyle(color:blue,fontSize: 17),)
                   )
                 ],
               ),
             ),
           ),
              ]
          ),
        ),
      ),
    );
  }
}

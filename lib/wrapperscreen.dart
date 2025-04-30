import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/Loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';

class Wrapperscreen extends StatefulWidget {
  const Wrapperscreen({super.key});

  @override
  State<Wrapperscreen> createState() => _WrapperscreenState();
}

class _WrapperscreenState extends State<Wrapperscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: StreamBuilder(
             stream: FirebaseAuth.instance.authStateChanges(),
             builder: (context,snapshot){
               if(snapshot.hasData){
                 return Homescreen();
               }else{
                 return Loginscreen();
               }
             },
           ),
    );
  }
}

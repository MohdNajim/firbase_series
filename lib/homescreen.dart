import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/apicall.dart';
import 'package:firebase_series/datePicker.dart';
import 'package:firebase_series/googlemapscreen.dart';
import 'package:firebase_series/tableScreen.dart';
import 'package:firebase_series/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? userEmail=FirebaseAuth.instance.currentUser?.email;

  List<Map<String, String>> itemList=[
    {
      "image":"assets/images/calendar.png",
      "title":"Calendar 2025"
    },
    {
      "image":"assets/images/googlemaps.png",
      "title":"Google maps"
    },
    {
      "image":"assets/images/datagrid.png",
      "title":"TableWidget"
    },
    {
      "image":"assets/images/datatable.png",
      "title":"apiIntegrate"
    },
    {
      "image":"assets/images/calendar.png",
      "title":"Calendar 2025"
    },
    {
      "image":"assets/images/calendar.png",
      "title":"Calendar 2025"
    },

  ];


  File? images;
  final picker=ImagePicker();
  Future<void> pickAndUploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images = File(pickedFile.path);
        // isUploading = true;
      });
    }
  }

  int? selectedIndex;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    String title=itemList[index]['title']??"";

   late Widget nextScreen;

    if(title=='Google maps'){
      nextScreen=OpenStreetMapScreen();
    }else if(title=="Calendar 2025"){
      nextScreen=DatePickerScreen();
    }else if(title=="TableWidget"){
      nextScreen=TableScreen();
    }else if(title=="apiIntegrate"){
      nextScreen=ApiCall();
    }
    Get.to(nextScreen);
  }

  Future<void> signOut()async{
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        iconTheme: IconThemeData(color: white,size: 25),
        actions: [
         IconButton(onPressed: (){
           signOut();
         },
             icon: Icon(Icons.logout,color: white,size: 25,)
         )

        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
               height: MediaQuery.of(context).size.height,
                ),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color:themeColor,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100),bottomRight: Radius.circular(100),),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:60,left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            pickAndUploadImage();
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(70)
                            ),
                            child: images!=null? Image.file(images!):Image.asset('assets/images/profile.png',fit: BoxFit.cover,),
                              ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Anuskha Sharma',style: TextStyle(color: darkBlack,fontSize: 17),),
                              if(userEmail!=null)
                              Text(userEmail!,style: TextStyle(color:grey50,fontSize: 17),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  top: 140,
                  right: 0,
                  child: GridView.builder(
                    shrinkWrap: true,
                      itemCount: itemList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,
                      ),
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap:(){
                            onItemTapped(index);
                          },
                          child: customGridView(
                              itemList[index]["image"]??"",
                              itemList[index]["title"]??""
                          ),
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}


Widget customGridView(String image,String title){
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: black12,
            blurRadius: 10,
            spreadRadius: 2
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,height: 120,width: 120,fit: BoxFit.cover,),
          Text(title,style: TextStyle(color: grey,fontSize: 17),)
        ],
      ),
    ),
  );
}


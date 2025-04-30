import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {

  RefreshController refreshController=RefreshController(initialRefresh: false);

  var posts=[].obs;
  Future<void> getApi()async{
final url=Uri.parse("https://jsonplaceholder.typicode.com/posts");
try{
  final response=await http.get(url);
  if(response.statusCode==200){
    setState(() {
      posts.assignAll(json.decode(response.body));
    });
  }else{
   posts.clear();
    }
}catch(e){
    posts.clear();
}
refreshController.refreshCompleted();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          onRefresh: getApi,
          header: ClassicHeader(),
          child: posts.isEmpty?
          Center(
            child: CircularProgressIndicator(),
          ):
          ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index){
                final post=posts[index];
                return Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: Text(post['id'].toString()),
                          title: Text(post['title']),
                          subtitle: Text(post['body']),
                        )
                      ],
                    ),
                    Divider()
                  ],
                );
              }),

        )

      )
    );
  }
}

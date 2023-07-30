import 'dart:convert';
// import 'dart:js_interop';

import 'package:chatapp/APIs/APIs.dart';
import 'package:chatapp/loginPage.dart';
import 'package:chatapp/cards/chatCard.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/navbar/googleNavbar.dart';
import 'package:flutter/material.dart';
class homePage extends StatefulWidget{
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>{
 @override
  void initState(){
    super.initState();
    APIs.selfInfo();

  }
  logout(){
    APIs.auth.signOut().then((value){
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=>loginPage()));
    });
  }
  List<chatUser> list=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
        // elevation: 5,
      ),
      body: StreamBuilder(
        stream: APIs.getAllUser(),
          builder: (context,snapshot){

          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child:CircularProgressIndicator());

            case ConnectionState.active:
            case ConnectionState.done:
              final data=snapshot.data!.docs;
              list=data.map((e) => chatUser.fromJson(e.data())).toList();
          }

            return ListView.builder(
              itemCount: list.length,
                physics:const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                itemBuilder: (context,index){
                  return chatCard(user: list[index]);
            });
          },
      ),
      bottomNavigationBar: const GoogleNavbar(index: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Friend',
        child: const Icon(Icons.add),
        // backgroundColor: Colors.green,
        onPressed: () {

        },
      ),
    );
  }

}
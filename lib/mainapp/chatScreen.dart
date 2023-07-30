// import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/cards/massageCard.dart';
import 'package:chatapp/models/massages_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show File, Platform;

import '../APIs/APIs.dart';
import '../models/chat_model.dart';

class chatScreen extends StatefulWidget {
  final chatUser user;
  const chatScreen({super.key,required this.user});

  @override
  State<chatScreen> createState() => _chatScreenState(user: user);
}

class _chatScreenState extends State<chatScreen> {

  final chatUser user;

  void initState(){
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
  }

  _chatScreenState({required this.user});

  List<Massages> list=[];
  final TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();
    final double mqwidth=MediaQuery.sizeOf(context).width;
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _controller.jumpTo(_controller.position.maxScrollExtent);
    // });
    return Container(
      color: Colors.lightBlueAccent,
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            centerTitle: true,
            // title:  Text("Home"),
            automaticallyImplyLeading: false,
            flexibleSpace: appbarForUser(mqwidth),

          ),

          body: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                    stream: APIs.getAllMassages(user.id.toString()),
                    builder: (context,snapshot){

                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const Center(child:CircularProgressIndicator());

                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data=snapshot.data!.docs;

                          list=data.map((e) => Massages.fromJson(e.data())).toList();

                          }
                      return ListView.builder(

                          itemCount: list.length,
                          reverse: true,
                          physics:const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          itemBuilder: (context,index){
                            return massageCard(massage: list[index],user_id:user.id);
                          });
                    },
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: mqwidth*0.02),
                child: inputBar(mqwidth),
              ),
            ],
          ),
        ),
      ),
    );

  }


  Widget appbarForUser(double mqwidth) {
    // double height = Scaffold.of(context).appBarMaxHeight!;
    return Container(
      width: mqwidth,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                margin: EdgeInsets.only(left: mqwidth*0.02),
                child: Platform.isIOS ? Icon(CupertinoIcons.back) : Icon(Icons.arrow_back_outlined,size: mqwidth*0.070,)),
          ),
          Container(margin: EdgeInsets.only(left: mqwidth*0.03,right: mqwidth*0.03),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(mqwidth*0.06),
              child: CachedNetworkImage(
                width: mqwidth*0.12,
                height: mqwidth*0.12,
                fit: BoxFit.cover,
                imageUrl: user.image,
                errorWidget: (context, url, error) => Icon(CupertinoIcons.person),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text(user.name,style: TextStyle(fontSize: mqwidth*0.05))),
                  Text('Last seen',style: TextStyle(fontSize: mqwidth*0.03)),
            ],

          ),
        ],
      ),
    );
  }


  Widget inputBar(double mqwidth){
    return Row(
      children: [
        Container(
          width: mqwidth*0.83,
          margin: EdgeInsets.symmetric(horizontal: mqwidth*0.025),
          child: Card(
            elevation: 3,
            color: Colors.white,
            child: Row(
              children: [
              Padding(
                padding: EdgeInsets.only(left: mqwidth*0.025),
                child: Icon(Icons.emoji_emotions_outlined,color: Colors.lightBlue.shade200,),
              ),
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Type Something...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none
                      ),
                      )
                    ),
                  ),
                Icon(Platform.isIOS? CupertinoIcons.camera_fill : Icons.camera_alt,color: Colors.lightBlue.shade200),
                Padding(
                  padding: EdgeInsets.only(right: mqwidth*0.025),
                  child: Icon(Platform.isIOS? CupertinoIcons.photo : Icons.photo_album_rounded,color: Colors.lightBlue.shade200),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            if(_controller.text.isNotEmpty){
              APIs.sendMassages(user.id, _controller.text.toString());
              _controller.clear();
            }
          },
            child: Icon(Platform.isIOS ? CupertinoIcons.arrow_right_circle_fill : Icons.send,size: mqwidth*0.09,color:Colors.green,))
      ],
    );
  }

}

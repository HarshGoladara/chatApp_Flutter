// import 'package:chatapp/loginPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/loginPage.dart';
import 'package:chatapp/mainapp/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../APIs/APIs.dart';
import '../models/chat_model.dart';

class chatCard extends StatelessWidget {
  // const chatCard({super.key});
  final chatUser user;
  chatCard({required this.user});
  @override
  Widget build(BuildContext context) {
    // print(APIs.lastmassage(user.id));
        return InkWell(
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 4,horizontal: 7),
            color: Colors.white,
            elevation: 2,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                  imageUrl: user.image,
                  errorWidget: (context, url, error) => Icon(CupertinoIcons.person),
                ),
              ),
              title: Text(user.name),
              subtitle:Text(user.email),
              trailing: Text('9:15'),
            ),
          ),
          onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>chatScreen(user: user)));
          },
        );
  }
}

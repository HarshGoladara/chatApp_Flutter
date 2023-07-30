import 'dart:io';

import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/massages_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../util/util.dart';

class APIs{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<bool> isUserExixst() async{
      return (await db.collection('users').doc(auth.currentUser!.uid).get()).exists;
  }
  static late chatUser me;

  static Future<void> selfInfo() async{
     await db.collection('users').doc(auth.currentUser!.uid).get().then((user)async{
       if(user.exists){
         me=chatUser.fromJson(user.data()!);
       }else{
         await CreateUser().then((value)=>selfInfo());
       }
     });
  }

  static Future<void> CreateUser() async{
    final User user=auth.currentUser!;
    final time=DateTime.now().millisecondsSinceEpoch.toString();
    final chatuser = chatUser(
        id: user.uid,
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        lastActive: time,
        isOnline: false,
        email: user.email.toString(),
        pushToken: '',
        about: 'Hey ! I am using this awesome chatApp'
    );
    return await db.collection('users').doc(user.uid).set(chatuser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser(){
    return db.collection('users').where('id',isNotEqualTo: auth.currentUser!.uid).snapshots();
  }

  static String getConvId(String sender_uid){
    return me.id.hashCode <= sender_uid.hashCode  ? '${me.id}_$sender_uid' : '${sender_uid}_${me.id}';
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMassages(String sender_uid){
    return db.collection('user/${getConvId(sender_uid)}/massages').orderBy('time',descending: true).snapshots();
  }

  static Future<void> updateProfile() async{
    await db.collection('users').doc(me.id).update({
      'name':me.name,
      'about':me.about,
    }).then((value){
      print('Completed');
    });
  }

  static Future<void> sendMassages(String sender_uid,String msg) async{
    String doc_id = (DateTime.now().millisecondsSinceEpoch).toString();
    final Massages massages=Massages(read: false, from: me.id, time: doc_id, to: sender_uid, type: Type.text, massage: msg);
    await db.collection('user/${getConvId(sender_uid)}/massages').doc(doc_id).set(massages.toJson());
  }

  static Future<void> readmassage(String doc_id,String sender_uid) async{
    await db.collection('user/${getConvId(sender_uid)}/massages').doc(doc_id).update({
      'read':true
    });
}

  static Future<QuerySnapshot<Map<String, dynamic>>> lastmassage(String sender_uid) async{
   return await db.collection('user/${getConvId(sender_uid)}/massages').limit(1).orderBy('time',descending: true).get().
   ;
  }
}
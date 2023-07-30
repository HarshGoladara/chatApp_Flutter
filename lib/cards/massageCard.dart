import 'package:chatapp/models/massages_model.dart';
import 'package:chatapp/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../APIs/APIs.dart';

class massageCard extends StatelessWidget {
  final Massages massage;
  final String user_id;
  massageCard({required this.massage,required this.user_id});

  @override
  Widget build(BuildContext context) {
    final DateTime time=Utils().getTime(massage.time.toString());
    // print(massage.time);
    final timeString='${time.hour}:${time.minute}';
    double mqwidth=MediaQuery.sizeOf(context).width;
    return massage.from==APIs.me.id ? greenMassages(mqwidth,timeString) : blueMassages(mqwidth,timeString);
  }

  Widget greenMassages(double mqwidth,String time){
    return Container(
      margin: EdgeInsets.only(top: mqwidth*0.03,right:mqwidth*0.01,left: mqwidth*0.05),
      alignment: Alignment.topRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.green
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(massage.massage,style: TextStyle(fontSize: 20,color: Colors.white),maxLines: null,),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  margin:  EdgeInsets.only(left:8.0),
                  child: Text(time,style: TextStyle(fontSize: 15,))),
              Icon(massage.read ? Icons.done_all : Icons.done,color:Colors.blue)
            ],
          )
        ],
      ),
    );
  }

  Widget blueMassages(double mqwidth,String time){
    APIs.readmassage(massage.time, user_id);
    return Container(
      margin: EdgeInsets.only(top: mqwidth*0.03,left: mqwidth*0.01,right: mqwidth*0.05),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius:const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.lightBlue.shade300
            ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(massage.massage,style: TextStyle(fontSize: 20),maxLines: null,),
              )),
          Container(
            margin:  EdgeInsets.only(left:8.0),
              child: Text(time,style: TextStyle(fontSize: 15,)))
        ],
      ),
    );
  }

  }

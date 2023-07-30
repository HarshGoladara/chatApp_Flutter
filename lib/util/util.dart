import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class Utils{

  void toastMasssages(massage){
    var ind=massage.toString().indexOf(']');
    var msgstr=massage.toString().substring(ind+1);
    Fluttertoast.showToast(
        msg: msgstr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackbar(BuildContext context,String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: Colors.lightBlue.withOpacity(0.7),
        behavior: SnackBarBehavior.floating,));
  }

  void bluetoastMasssages(massage){
    var ind=massage.toString().indexOf(']');
    var msgstr=massage.toString().substring(ind+1);
    Fluttertoast.showToast(
        msg: msgstr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 13
    );
  }

   DateTime getTime(String time){
    var date= DateTime.fromMicrosecondsSinceEpoch(int.parse(time)*1000);
    return date;
  }
}
import 'package:flutter/material.dart';
import 'package:chatapp/loginPage.dart';
import 'package:chatapp/APIs/APIs.dart';
import 'package:chatapp/navbar/googleNavbar.dart';
class groupPage extends StatefulWidget {
  const groupPage({super.key});

  @override
  State<groupPage> createState() => _groupPageState();
}

class _groupPageState extends State<groupPage> {
  logout(){
    APIs.auth.signOut().then((value){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>loginPage()));
    });
  }
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
      body: Text('Hii from group Chat'),
      bottomNavigationBar: const GoogleNavbar(index: 1),
    );
  }
}

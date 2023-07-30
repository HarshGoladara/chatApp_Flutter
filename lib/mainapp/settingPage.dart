import 'package:flutter/material.dart';
import 'package:chatapp/loginPage.dart';
import 'package:chatapp/APIs/APIs.dart';
import 'package:chatapp/navbar/googleNavbar.dart';

class settingPage extends StatefulWidget {
  const settingPage({super.key});

  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
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
      body: const Text('Hii from setting Page'),
      bottomNavigationBar: const GoogleNavbar(index: 3),
    );
  }
}

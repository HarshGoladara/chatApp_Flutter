import 'dart:io';

import 'package:chatapp/APIs/APIs.dart';
import 'package:chatapp/mainapp/homePage.dart';
import 'package:chatapp/util/util.dart';
import 'package:email_validator/email_validator.dart';
import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginPage extends StatefulWidget{
  @override
  State<loginPage> createState() => loginPageState();

}

class loginPageState extends State<loginPage> {

  var emailId=TextEditingController();
  var password=TextEditingController();
  var flag=true;
  final _formkey=GlobalKey<FormState>();
  Icon eyeIcon=const Icon(Icons.remove_red_eye_outlined,color: Colors.redAccent);
  // FirebaseAuth _auth = FirebaseAuth.instance;
  bool loding =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: const Text("Login Page"),
      ),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlue.shade50,
                  Colors.lightBlue.shade100,
                  Colors.lightBlue.shade200,
                  Colors.lightBlue.shade300
                ]
            )
        ),
        child: Center(
          child: Hero(
            tag: 'pageChange',
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Card(
                      elevation: 7,
                      child: Container(
                        width: 350,
                        // height: 500,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60,right: 20,left: 20),
                          child: Form(
                            key: _formkey,
                            child: Column(children: [
                              textFieldUser(emailId),
                              Container(height: 20,),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: password,
                                obscureText: flag,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: const BorderSide(
                                            color: Colors.black
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: BorderSide(
                                            color: Colors.lightBlueAccent.shade100, width: 2)
                                    ),
                                    hintText: 'Password',
                                    prefixIcon:IconButton(
                                      icon: eyeIcon,
                                      onPressed: (){
                                        if(flag==true){
                                          eyeIcon=const Icon(Icons.disabled_visible_outlined,color: Colors.redAccent,);
                                        }
                                        else{
                                          eyeIcon=const Icon(Icons.remove_red_eye_outlined,color: Colors.redAccent,);
                                        }
                                        flag=!flag;
                                        setState(() {});
                                      },
                                    )
                                ),
                                validator: (value){
                                  if(value!.length<8){
                                    return 'Password must contain 8 letters';
                                  }
                                  return null;
                                },
                              ),
                              Container(height: 20,),
                              ElevatedButton(
                                onPressed: (){
                                  // String uName=userName.text.toString();
                                  // String uPass=password.text.toString();
                                  if(_formkey.currentState!.validate()){
                                    setState(() {
                                      loding=true;
                                    });

                                    APIs.auth.signInWithEmailAndPassword
                                      (email: emailId.text.toString(), password: password.text.toString()).then((value){
                                        setState(() {
                                          loding=false;
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              PageRouteBuilder(
                                                  transitionDuration: const Duration(milliseconds: 800),
                                                  reverseTransitionDuration:const Duration(milliseconds: 800),
                                                  pageBuilder: (_, __, ___) => homePage()),
                                            ModalRoute.withName("/")
                                          );
                                        });
                                    }).catchError((error,stacktrace){
                                      setState(() {
                                        loding=false;
                                      });
                                      Utils().toastMasssages(error);
                                    });

                                  }
                                },
                                style: const ButtonStyle(
                                  backgroundColor:MaterialStatePropertyAll<Color>(Colors.lightBlueAccent),
                                  padding:MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.only(top: 13,bottom: 13,right: 30,left: 30)),
                                  elevation: MaterialStatePropertyAll<double>(3.0),
                                ),
                                child: loding?const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                ): const Text("Login",style: TextStyle(color: Colors.black),),
                              ),
                              const Padding(
                                padding:EdgeInsets.only(top: 20,bottom: 30),
                                child: DottedLine(
                                  direction: Axis.horizontal,
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: signinWithGoogle,
                                    child: const circledAvtar(photoPath: 'assets/images/google.png'),
                                  ),
                                  const circledAvtar(photoPath: 'assets/images/facebook.png'),
                                  const circledAvtar(photoPath: 'assets/images/linkdin.png'),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 40,bottom: 30),
                                child: Row(
                                  children: [
                                    const Text("Don't have an account? ",style: TextStyle(fontSize: 15),),
                                    InkWell(
                                      child:const Text("Sign Up",
                                        style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline,fontSize: 15,decorationColor: Colors.blue ),
                                      ),
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> signUpPage()));
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                transitionDuration: const Duration(milliseconds: 800),
                                                reverseTransitionDuration:const Duration(milliseconds: 800),
                                                pageBuilder: (_, __, ___) => signUpPage()));
                                      },
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 140),
                    child: const CircleAvatar(
                      foregroundImage:AssetImage('assets/images/user3.png'),
                      radius: 35,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  signinWithGoogle() async{

    await InternetAddress.lookup('google.com').then((value) async{
      GoogleSignInAccount ? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken ,
        accessToken: googleAuth.accessToken,
      );

      APIs.auth.signInWithCredential(credential).then((value) async{
        if(await APIs.isUserExixst()){
          Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 800),
                  reverseTransitionDuration:const Duration(milliseconds: 800),
                  pageBuilder: (_, __, ___) => homePage()),
              ModalRoute.withName("/")
          );
        }else{
          await APIs.CreateUser().then((value){
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 800),
                    reverseTransitionDuration:const Duration(milliseconds: 800),
                    pageBuilder: (_, __, ___) => homePage()),
                ModalRoute.withName("/")
            );
          });
        }

      }).catchError((error,stacktrac){
        Utils().toastMasssages(error);
      });
    }).catchError((error,stacktrac){
      Utils().toastMasssages('Netwwork Error');
    });


  }

}

class textFieldUser extends StatelessWidget{
  var userName=TextEditingController();
  textFieldUser(userName){
    this.userName=userName;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: userName,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Email-Id',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Colors.black
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                  color: Colors.lightBlueAccent.shade100, width: 2)
          ),
          prefixIcon:IconButton(
            icon: const Icon(Icons.email_outlined,color: Colors.lightBlue,),
            onPressed: (){

            },
          ),
      ),
      validator:(value){
        if(value!.isEmpty){
          return 'Email Id cannot be empty';
        }
        else if(!EmailValidator.validate(value)){
          return 'Email Id is not valid';
        }
        return null;
      },
    );
  }

}

class circledAvtar extends StatelessWidget{
  final String photoPath;

  const circledAvtar({required this.photoPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: CircleAvatar(
        foregroundImage: AssetImage(photoPath),
        radius: 30,
      ),
    );
  }

}


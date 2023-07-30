import 'package:chatapp/APIs/APIs.dart';
import 'package:chatapp/mainapp/homePage.dart';
import 'package:chatapp/util/util.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:io';

class signUpPage extends StatefulWidget {
  @override
  State<signUpPage> createState() => signUpPageState();
}

class signUpPageState extends State<signUpPage>
    with SingleTickerProviderStateMixin {
  final _formkey = GlobalKey<FormState>();
  var userName = TextEditingController();
  var emailId = TextEditingController();
  var mobileNo = TextEditingController();
  var password = TextEditingController();
  var confPassword = TextEditingController();
  var flag = true;
  Icon eyeIcon = const Icon(Icons.remove_red_eye_outlined, color: Colors.redAccent);
  final List<String> genderItems = ['Male', 'Female', 'other'];
  String? selectedValue;
  Icon genderIcon = const Icon(
    Icons.man,
    color: Colors.blue,
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: const Text("SignUp Page"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlue.shade50, Colors.lightBlue.shade300])),
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
                        // height: 670,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 60, right: 20, left: 20),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                CustomisedTextfield(
                                  hintString: 'Email-Id',
                                  keyBoardType: TextInputType.emailAddress,
                                  fieldIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.blue,
                                  ),
                                  name: emailId,
                                ),
                                sizedBox(),
                                CustomisedTextfield(
                                    hintString: 'User Name',
                                    keyBoardType: TextInputType.name,
                                    fieldIcon: const Icon(
                                      Icons.account_box_outlined,
                                      color: Colors.blue,
                                    ),
                                    name: userName),
                                sizedBox(),
                                CustomisedTextfield(
                                    hintString: 'Mobile No.',
                                    keyBoardType: TextInputType.number,
                                    fieldIcon: const Icon(
                                      Icons.phone_android_outlined,
                                      color: Colors.blue,
                                    ),
                                    name: mobileNo),
                                sizedBox(),
                                DropdownButtonFormField2(
                                    isDense: false,
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            borderSide: BorderSide(
                                                color: Colors
                                                    .lightBlueAccent.shade100,
                                                width: 2)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 9)),
                                    hint: Row(
                                      children: [
                                        genderIcon,
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(left: 9),
                                          child: Text(
                                            'Select Your Gender',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: genderItems
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select gender.';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      selectedValue = value.toString();
                                      if (value.toString() == 'Male') {
                                        genderIcon = const Icon(
                                          Icons.male,
                                          color: Colors.blue,
                                        );
                                        setState(() {});
                                      }
                                    },
                                    onChanged: (value) {
                                      if (value.toString() == 'Male') {
                                        genderIcon = const Icon(
                                          Icons.male,
                                          color: Colors.blue,
                                        );
                                        setState(() {});
                                      }
                                    },
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 24,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    )),
                                sizedBox(),
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: password,
                                  obscureText: flag,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          borderSide:
                                          const BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .lightBlueAccent.shade100,
                                              width: 2)),
                                      hintText: 'Password',
                                      prefixIcon: IconButton(
                                        icon: eyeIcon,
                                        onPressed: () {
                                          if (flag == true) {
                                            eyeIcon = const Icon(
                                              Icons.disabled_visible_outlined,
                                              color: Colors.redAccent,
                                            );
                                          } else {
                                            eyeIcon = const Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.redAccent,
                                            );
                                          }
                                          flag = !flag;
                                          setState(() {});
                                        },
                                      )),
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return 'Password most contain min 8 letter';
                                    }
                                    return null;
                                  },
                                ),
                                sizedBox(),
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: confPassword,
                                  obscureText: flag,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          borderSide:
                                          const BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          borderSide: BorderSide(
                                              color: Colors
                                                  .lightBlueAccent.shade100,
                                              width: 2)),
                                      hintText: 'Confirm Password',
                                      prefixIcon: IconButton(
                                        icon: eyeIcon,
                                        onPressed: () {
                                          if (flag == true) {
                                            eyeIcon = const Icon(
                                              Icons.disabled_visible_outlined,
                                              color: Colors.redAccent,
                                            );
                                          } else {
                                            eyeIcon = const Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.redAccent,
                                            );
                                          }
                                          flag = !flag;
                                          setState(() {});
                                        },
                                      )),
                                  validator: (value) {
                                    if (value != password.text.toString()) {
                                      return 'Password is not match';
                                    }
                                    return null;
                                  },
                                ),
                                sizedBox(),
                                ElevatedButton(
                                  onPressed: () async{
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        loding = true;
                                      });



                                      try{
                                        await _auth.createUserWithEmailAndPassword(email: emailId.text.toString(), password: password.text.toString());
                                      }catch(error){
                                        setState(() {
                                          loding=false;
                                        });
                                        Utils().toastMasssages(error);
                                      }finally{
                                        setState(() {
                                          loding=false;
                                        });
                                      };

                                      if(_auth.currentUser!=null){
                                          _auth.currentUser!.updateDisplayName(userName.text.toString()).then((value){
                                            APIs.CreateUser().then((value){
                                              Navigator.pushReplacement(
                                                  context,
                                                  PageRouteBuilder(
                                                      transitionDuration:
                                                      const Duration(milliseconds: 800),
                                                      reverseTransitionDuration:
                                                      const Duration(milliseconds: 800),
                                                      pageBuilder: (_, __, ___) =>
                                                          homePage()));
                                            });
                                          });
                                      }

                                      // _auth
                                      //     .createUserWithEmailAndPassword(
                                      //         email: emailId.text.toString(),
                                      //         password:
                                      //             password.text.toString())
                                      //     .then((value) async{
                                      //   _auth.currentUser!.updateDisplayName(userName.text.toString());
                                      //   print(_auth.currentUser!.displayName.toString());
                                      //   print(userName.text.toString());
                                      //   setState(() {
                                      //     loding = false;
                                      //   });
                                      //   // PhoneAuthCredential
                                      //   APIs.CreateUser().then((value){
                                      //     Navigator.pushReplacement(
                                      //         context,
                                      //         PageRouteBuilder(
                                      //             transitionDuration:
                                      //             const Duration(milliseconds: 800),
                                      //             reverseTransitionDuration:
                                      //             const Duration(milliseconds: 800),
                                      //             pageBuilder: (_, __, ___) =>
                                      //                 homePage()));
                                      //   });
                                      //   // _auth.currentUser!.updatePhoneNumber(mobileNo.text.toString());
                                      // }).catchError((error, stacktrace) {
                                      //   setState(() {
                                      //     loding = false;
                                      //   });
                                      //   Utils().toastMasssages(error);
                                      // });
                                    }
                                  },
                                  child: (loding
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth:1,
                                        )
                                      : const Text(
                                          "Sign Up",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.lightBlueAccent),
                                    padding: MaterialStatePropertyAll<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.only(
                                            top: 13,
                                            bottom: 13,
                                            right: 30,
                                            left: 30)),
                                    elevation:
                                        MaterialStatePropertyAll<double>(3.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 40, bottom: 25),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Already have an account? ",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      InkWell(
                                        child: const Text(
                                          "Sign In",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 15,
                                              decorationColor: Colors.blue),
                                        ),
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> loginPage()));
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  transitionDuration: const Duration(
                                                      milliseconds: 800),
                                                  reverseTransitionDuration:
                                                  const Duration(
                                                          milliseconds: 800),
                                                  pageBuilder: (_, __, ___) =>
                                                      loginPage()));
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 140),
                    child: const CircleAvatar(
                      foregroundImage: AssetImage('assets/images/user3.png'),
                      radius: 35,
                      backgroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomisedTextfield extends StatelessWidget {
  final String hintString;
  final TextInputType keyBoardType;
  final Icon fieldIcon;
  var name = TextEditingController();

  CustomisedTextfield(
      {required this.hintString,
      required this.keyBoardType,
      required this.fieldIcon,
      required this.name});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: name,
      maxLength: hintString=='Mobile No.' ? 10 : 100,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
          hintText: hintString,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent.shade100, width: 2)),
          prefixIcon: IconButton(
            icon: fieldIcon,
            onPressed: () {},
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintString cannot be empty';
        } else if (hintString == 'Email-Id' &&
            !EmailValidator.validate(value)) {
          return 'Email Id is not valid';
        } else if (hintString == 'Mobile No.' && value.length != 10) {
          return 'Mobile no is not valid';
        }
        return null;
      },
    );
  }
}

class sizedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

import 'dart:io' show File, Platform;
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/loginPage.dart';
import 'package:chatapp/APIs/APIs.dart';
import 'package:chatapp/navbar/googleNavbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../models/chat_model.dart';
import '../util/util.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final useName=TextEditingController();
  final about=TextEditingController();
  final _formkey = GlobalKey<FormState>();
  late chatUser user;
  @override
  void initState(){
    super.initState();
    user = APIs.me;
    useName.text=APIs.me.name;
    about.text=APIs.me.about;
  }

  logout() {
    APIs.auth.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => loginPage()));
    });
  }
 String? _image;
 bool loding=false;
  @override
  Widget build(BuildContext context) {


    void updateProfilePhoto(File image,BuildContext context) async{

      String exe=image.path.split('.').last;
      Reference ref = FirebaseStorage.instance.ref();
      final imageRef=ref.child('images/${APIs.me.id}.$exe');
      await imageRef.putFile(image,SettableMetadata(contentType: 'image/$exe')).then((snapshort) {
        imageRef.getDownloadURL().then((url) async{
          await APIs.db.collection('users').doc(APIs.me.id).update({'image':url });
          Utils().customSnackbar(context, 'Updeded Sucessfully');
          setState(() {
            loding=false;
          });
        });
      });

    }

    //Variable Declaration
    double mqheight = MediaQuery.of(context).size.height;
    double mqwidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          centerTitle: true,
          title: const Text("Home"),
          actions: [
            IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
          ],
          // elevation: 5,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
              key: _formkey,
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children:[
                        Container(
                          margin: EdgeInsets.only(top: mqheight * 0.05),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(mqheight * 0.1),
                            child: _image==null ?CachedNetworkImage(
                              width: mqheight * 0.20,
                              height: mqheight * 0.20,
                              fit: BoxFit.cover,
                              imageUrl: user.image,
                              progressIndicatorBuilder: (context,url,progress)=> CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Container(child: Icon(CupertinoIcons.person_alt,size: mqwidth*0.3,color: Colors.white,),color: Colors.grey.shade500,),
                            ) : (
                                Image.file(
                                  File(_image!),
                                  width: mqheight * 0.20,
                                  height: mqheight * 0.20,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: (){
                              _showbottomsheetBar();
                            },
                          style: ButtonStyle(
                            backgroundColor:MaterialStatePropertyAll<Color>(Colors.lightBlue.shade50),
                            shape:MaterialStatePropertyAll<OutlinedBorder> (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            )),
                          ),
                            child: Platform.isIOS ?  const Icon(CupertinoIcons.camera_on_rectangle_fill) : const Icon(Icons.add_a_photo_outlined,size: 20,),
                        )
                      ]
                    ),
                    textformfield(
                        labelString: 'User Name',
                        mqwidth: mqwidth,
                        mqheight: mqheight, controller: useName,),
                    textformfield(
                        labelString: 'About',
                        mqwidth: mqwidth,
                        mqheight: mqheight, controller: about,),
                    Container(
                      margin: EdgeInsets.only(top: mqheight * 0.05),
                      width: mqwidth * 0.4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.lightBlue.shade400),
                            foregroundColor:
                                const MaterialStatePropertyAll<Color>(Colors.white)),
                        child: loding ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ) : const Text('Update'),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if(_formkey.currentState!.validate()){
                            APIs.me.name=useName.text.toString();
                            APIs.me.about=about.text.toString();
                            if(_image!=null){
                              setState(() {
                                loding=true;
                              });
                                APIs.updateProfile();
                                updateProfilePhoto(File(_image!),context);
                            }
                            else{
                              APIs.updateProfile().then((value){
                                Utils().customSnackbar(context, 'Profile Updated Sucessfully');
                              }).catchError((error){
                                Utils().toastMasssages(error);
                              });
                              setState(() {
                              });
                            }

                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            ],
          ),
        ),
        bottomNavigationBar: const GoogleNavbar(index: 2),
      ),
    );

  }



  Future<void> _showbottomsheetBar() async {
    final double mqwidth=MediaQuery.sizeOf(context).width;
    showModalBottomSheet(
        context: context,
        backgroundColor:Colors.white,
        shape:const  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
        ),
        builder: (_){
      return ListView(
          shrinkWrap:true,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: mqwidth*0.09,bottom: mqwidth*0.09),
              child: Text('Pick photo',style: TextStyle(fontSize: 25),),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: mqwidth*0.09),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Ink(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(90.0)),
                  child: InkWell(
                    onTap:() async{
                      final ImagePicker picker = ImagePicker();
                      final XFile? photo = await picker.pickImage(source: ImageSource.camera,imageQuality: 75,);
                      if(photo!=null){
                        setState(() {
                          _image=photo.path;
                          Navigator.pop(context);
                        });
                      };
                    },

                      child: const Padding(
                        padding:  EdgeInsets.all(20),
                        child: Icon(Icons.add_a_photo,size: 80),
                      )
                  ),
                ),
                Ink(
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(90.0)),
                  child: InkWell(
                      onTap:() async{
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 75);
                        if(image!=null){
                          setState(() {
                            // APIs.updateProfilePhoto(File(image.path));
                            _image=image.path;
                            Navigator.pop(context);
                          });
                        }
                      },

                      child: const Padding(
                        padding: EdgeInsets.all(20),
                          child: Icon(CupertinoIcons.photo,size: 80)
                      )
                  ),
                ),

              ],
            ),
          )
        ],
      );
    });
  }
}

class textformfield extends StatelessWidget {
  final labelString;
  final TextEditingController controller; 
  final double mqwidth, mqheight;
  textformfield(
      {required this.controller,
        required this.labelString,
        required this.mqwidth,
        required this.mqheight});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mqheight * 0.05),
      width: mqwidth * 0.75,
      child: TextFormField(
        controller: controller,
        keyboardType:TextInputType.name,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent.shade100, width: 2)),
          labelText: labelString,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be null';
          }
          return null;
        },
      ),
    );
  }
}


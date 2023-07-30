import 'dart:io' show Platform;
import 'package:chatapp/mainapp/groupPage.dart';
import 'package:chatapp/mainapp/homePage.dart';
import 'package:chatapp/mainapp/profilePage.dart';
import 'package:chatapp/mainapp/settingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../util/util.dart';


class GoogleNavbar extends StatelessWidget {
  final int index;
  const GoogleNavbar({required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue.shade100,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10,left: 10,right: 10),
        child: GNav(
          selectedIndex: index,
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(color: Colors.black, width: 1),
          iconSize: 24,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 50),
          activeColor: Colors.white,
          tabBackgroundColor: Colors.lightBlue.shade500,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tabs: [
            GButton(
              icon:Platform.isIOS ? CupertinoIcons.home : Icons.home_outlined,
            ),
            GButton(
              icon:Platform.isIOS ? CupertinoIcons.group_solid : Icons.groups_2_outlined,
            ),
            GButton(
              icon: Platform.isIOS ? CupertinoIcons.person : Icons.account_box_outlined,
            ),
            GButton(
              icon: Platform.isIOS ?  CupertinoIcons.settings : Icons.settings,
            )
          ],
          onTabChange: (index) {
            if (index == 0) {
              Navigator.pushReplacement(context, CustomPageRoute(
                builder: (BuildContext context) {
                  return homePage();
                },
              ));
            } else if (index == 1) {
              // Navigator.pushReplacement(context, CustomPageRoute(
              //   builder: (BuildContext context) {
              //     return const groupPage();
              //   },
              // ));
              Utils().bluetoastMasssages('This Feature is under development');
            } else if (index == 2) {
              Navigator.pushReplacement(context, CustomPageRoute(
                builder: (BuildContext context) {
                  return const profilePage();
                },
              ));
            } else {
              // Navigator.pushReplacement(context, CustomPageRoute(
              //   builder: (BuildContext context) {
              //     return const settingPage();
              //   },
              // ));
              Utils().bluetoastMasssages('This Feature is under development');
            }
          },
        ),
      ),
    );
  }
}

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

// class GoogleNavbar extends StatefulWidget {
//   const GoogleNavbar({super.key});
//
//   @override
//   State<GoogleNavbar> createState() => _GoogleNavbarState();
// }
//
// class _GoogleNavbarState extends State<GoogleNavbar> {
//   @override
//   Widget build(BuildContext context) {
//     return GNav(
//         rippleColor: const Color(0xFF424242), // tab button ripple color when pressed
//         hoverColor: const Color(0xFF455A64), // tab button hover color
//         haptic: true, // haptic feedback
//         tabBorderRadius: 15,
//         tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
//         tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
//         tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
//         curve: Curves.easeOutExpo, // tab animation curves
//         duration: const Duration(milliseconds: 900), // tab animation duration
//         gap: 8, // the tab button gap between icon and text
//         color: Colors.grey[800], // unselected icon color
//         activeColor: Colors.purple, // selected icon and text color
//         iconSize: 24, // tab button icon size
//         tabBackgroundColor: Colors.purple.withOpacity(0.1), // selected tab background color
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         tabs: [
//       GButton(
//         icon: MdiIcons.home,
//         text: 'Home',
//       ),
//       const GButton(
//         icon: FontAwesomeIcons.peopleGroup,
//         text: 'Add Frd',
//       ),
//       GButton(
//         icon: MdiIcons.faceManProfile,
//         text: 'Profile',
//       ),
//       GButton(
//         icon: MdiIcons.accountSettings,
//         text: 'Settings',
//       )
//     ]);
//   }
// }

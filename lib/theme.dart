import 'package:flutter/material.dart';

class BasilTheme{
  BasilTheme({
    this.primaryColor=const Color(0xFF356859),
    this.tertiaryColor=const Color(0xFFFF5722),
    this.neutralColor=const Color(0xFFFFFBE6),
});
  final primaryColor,tertiaryColor,neutralColor;

  ThemeData tothemeData(){
    return ThemeData(useMaterial3: true);
  }
}

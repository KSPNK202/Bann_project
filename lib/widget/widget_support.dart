import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppWidget {
  static TextStyle boldTextFeildStyle() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Kanit');
  }

  // ignore: non_constant_identifier_names
  static TextStyle HeadlineTextFeildStyle() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Kanit');
  }

  // ignore: non_constant_identifier_names
  static TextStyle LightTextFeildStyle() {
    return const TextStyle(
        color: Colors.black87,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Kanit');
  }

  // ignore: non_constant_identifier_names
  static TextStyle IconHomeTextFeildStyle() {
    return const TextStyle(
        color: Colors.black87,
        fontSize: 14.0, // ขนาดฟอนต์
        fontWeight: FontWeight.bold, // น้ำหนักฟอนต์
        fontFamily: 'Kanit');
  }

  static semiBoldTextFeildStyle() {
    return const TextStyle(
        color: Colors.black87,
        fontSize: 20.0, // ขนาดฟอนต์
        fontWeight: FontWeight.bold, // น้ำหนักฟอนต์
        fontFamily: 'Kanit');
  }

  static ligthtextTextFeildStyle() {
    return const TextStyle(
        color: Colors.black54,
        fontSize: 14.0, // ขนาดฟอนต์
        fontWeight: FontWeight.bold, // น้ำหนักฟอนต์
        fontFamily: 'Kanit');
  }
}

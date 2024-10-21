import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // ตัวแปรสำหรับเก็บสถานะธีม
  bool _isDarkTheme = false;

  // Getter สำหรับเข้าถึงสถานะธีม
  bool get isDarkTheme => _isDarkTheme;

  // ฟังก์ชันสำหรับเปลี่ยนธีม
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners(); // แจ้งให้ผู้ฟังทราบว่ามีการเปลี่ยนแปลง
  }

  // ฟังก์ชันสำหรับคืนค่าธีมที่เหมาะสม
  ThemeData get currentTheme {
    return _isDarkTheme ? ThemeData.dark() : ThemeData.light();
  }
}
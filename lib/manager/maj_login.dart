import 'package:baan_app/manager/choose_carector.dart';
import 'package:baan_app/manager/managerpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MajLogin extends StatefulWidget {
  const MajLogin({super.key});

  @override
  State createState() => _MajLoginState();
}

class _MajLoginState extends State<MajLogin> {
  final GlobalKey _formkey = GlobalKey();
  TextEditingController _mausernamecontorller = TextEditingController();
  TextEditingController _mapasswordcontorller = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ChooseCarector()));
          },
        ),
      ),
      body: SingleChildScrollView( // เพิ่ม SingleChildScrollView
        child: Container(
          child: Stack(children: [
            Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const Text(
                      "ระบบผู้จัดการร้าน",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'kanit',
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 50.0),
                            Container(
                              padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromARGB(255, 160, 160, 147)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: _mausernamecontorller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกชื่อผู้ใช้';
                                    }
                                    return null; // เพิ่มการคืนค่า null เมื่อไม่มีข้อผิดพลาด
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "ชื่อผู้ใช้",
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 160, 160, 147),
                                      fontFamily: 'kanit',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromARGB(255, 160, 160, 147)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: _mapasswordcontorller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกรหัสผ่าน';
                                    }
                                    return null; // เพิ่มการคืนค่า null เมื่อไม่มีข้อผิดพลาด
                                  },
                                  obscureText: !_passwordVisible, // ใช้ตัวแปรเพื่อควบคุมการแสดงรหัสผ่าน
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "รหัสผ่าน",
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 160, 160, 147),
                                      fontFamily: 'kanit',
                                    ),
                                    
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Color.fromARGB(255, 160, 160, 147),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible; // เปลี่ยนสถานะการแสดงรหัสผ่าน
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            GestureDetector(
                              onTap: () {
                                LoginAdmin();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "เข้าสู่ระบบ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'kanit',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void LoginAdmin() {
  FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
    snapshot.docs.forEach((result) {
      if (result.data()['id'] != _mausernamecontorller.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber,
          content: Text(
            "เข้าสู่ระบบ",
            style: TextStyle(fontFamily: 'kanit', fontSize: 18),
          ),
        ));
      } else if (result.data()['password'] != _mapasswordcontorller.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber,
          content: Text(
            "รหัสผ่านไม่ถูกต้อง",
            style: TextStyle(fontFamily: 'kanit', fontSize: 18),
          ),
        ));
      } else {
        Route route = MaterialPageRoute(builder: (context) => ManagerPage());
        Navigator.pushReplacement(context, route);
      }
    });
  });
}
}
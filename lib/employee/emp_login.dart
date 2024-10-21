
import 'package:baan_app/employee/employeepage.dart';
import 'package:baan_app/manager/choose_carector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmpLogin extends StatefulWidget {
  const EmpLogin({super.key});

  @override
  State<EmpLogin> createState() => _EmpLoginState();
}

class _EmpLoginState extends State<EmpLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _emusernamecontorller = TextEditingController();
  TextEditingController _empasswordcontorller = TextEditingController();
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
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height),
              padding: const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(MediaQuery.of(context).size.width, 110.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const Text(
                      "ระบบพนักงาน",
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
                                  controller: _emusernamecontorller,
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
                                  controller: _empasswordcontorller,
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
                                LoginEmployee();
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

  void LoginEmployee() {
  FirebaseFirestore.instance.collection("Employee").get().then((snapshot) {
    snapshot.docs.forEach((result) {
      if (result.data()['id'] != _emusernamecontorller.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber,
          content: Text(
            "ชื่อผู้ใช้ไม่ถูกต้อง",
            style: TextStyle(fontFamily: 'kanit', fontSize: 18),
          ),
        ));
      } else if (result.data()['password'] != _empasswordcontorller.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber,
          content: Text(
            "รหัสผ่านไม่ถูกต้อง",
            style: TextStyle(fontFamily: 'kanit', fontSize: 18),
          ),
        ));
      } else {
        Route route = MaterialPageRoute(builder: (context) => EmployeePage());
        Navigator.pushReplacement(context, route);
      }
    });
  });
}
}
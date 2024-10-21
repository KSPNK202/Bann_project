import 'package:baan_app/user/models/database.dart';
import 'package:baan_app/user/models/shared_pref.dart';
import 'package:baan_app/user/pages/bottomnav.dart';
import 'package:baan_app/user/pages/login.dart';
import 'package:baan_app/widget/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SingUpState();
}

class _SingUpState extends State<SignUp> {
  String username = "",
      phonenumber = "",
      email = "",
      password = "",
      confirmpassword = "";

  final TextEditingController _usernamecontorller = TextEditingController();

  final TextEditingController _phonenumbercontorller = TextEditingController();

  final TextEditingController _emailcontorller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          "ลงทะเบียนสำเร็จ",
          style: TextStyle(fontSize: 20.0, fontFamily: 'kanit'),
        ),
      ));

    String Id = randomAlphaNumeric(10);
    Map<String, dynamic> addUserInfo= {
      "ชื่อ" : _usernamecontorller.text,
      "อีเมล" : _emailcontorller.text,
      "หมายเลขโทรศัพท์" : _phonenumbercontorller.text,
      "Id" : Id,
    };
    await DatabaseMethods().addUserDetail(addUserInfo, Id);
    await SharedPreferenceHelper().saveUserName(_usernamecontorller.text);
    await SharedPreferenceHelper().saveUserEmail(_emailcontorller.text);
    await SharedPreferenceHelper().saveUserPhonenumber(_phonenumbercontorller.text);
    await SharedPreferenceHelper().saveUserId(Id);


      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNav()));
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Password Provided is too Weak",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      } else if (e.code == "email-a-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Account Already exsists",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      }
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // ใช้ SingleChildScrollView
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xFFFFFF00),
                      Color(0xFFFFCC00),
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: const Text(""),
              ),
              
              Container(
                margin: const EdgeInsets.only(
                  top: 70.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Expanded(
                  child: Column(
                    children: [
                      
                      Container(
                          child: Image.asset(
                        "images/logo_3.png",
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.cover,
                      )
                    
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "สมัครสมาชิก",
                                  style: AppWidget.HeadlineTextFeildStyle(),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _usernamecontorller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกชื่อผู้ใช้';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'ชื่อผู้ใช้',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                    prefixIcon: const Icon(Icons.person_outlined),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _phonenumbercontorller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกเบอร์โทรศัพท์';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'เบอร์โทรศัพท์',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                    prefixIcon: const Icon(Icons.phone_outlined),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _emailcontorller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกอีเมล';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'อีเมล',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                    prefixIcon: const Icon(Icons.email_outlined),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกรหัสผ่าน';
                                    }
                                    return null;
                                  },
                                  obscureText:
                                      _obscureTextPassword, // ใช้ตัวแปรที่กำหนด
                                  decoration: InputDecoration(
                                    hintText: 'รหัสผ่าน',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(), // ปรับแต่งตามต้องการ
                                    prefixIcon:
                                        const Icon(Icons.lock_outline_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureTextPassword
                                            ? Icons.visibility_off
                                            : Icons
                                                .visibility, // เปลี่ยนไอคอนตามสถานะ
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureTextPassword = !_obscureTextPassword; // สลับสถานะการมองเห็น
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกรหัสผ่าน';
                                    }
                                    return null;
                                  },
                                  obscureText:
                                      _obscureTextConfirmPassword, // ใช้ตัวแปรที่กำหนด
                                  decoration: InputDecoration(
                                    hintText: 'ยืนยันรหัสผ่าน',
                                    hintStyle: AppWidget.semiBoldTextFeildStyle(), // ปรับแต่งตามต้องการ
                                    prefixIcon:
                                        const Icon(Icons.lock_outline_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureTextConfirmPassword
                                            ? Icons.visibility_off
                                            : Icons
                                                .visibility, // เปลี่ยนไอคอนตามสถานะ
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureTextConfirmPassword = !_obscureTextConfirmPassword; // สลับสถานะการมองเห็น
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        username = _usernamecontorller.text;
                                        phonenumber = _phonenumbercontorller.text;
                                        email = _emailcontorller.text;
                                        password = _passwordController.text;
                                        confirmpassword =
                                            _confirmPasswordController.text;
                                      });
                                    }
                                    registration();
                                  },
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFCC00),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                          child: Text(
                                        "สมัครสมาชิก",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontFamily: 'Kanit'),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("มีบัญชีผู้ใช้อยู่แล้ว?",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Kanit')),
                            const SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LogIn(),
                                  ),
                                );
                              },
                              child: Text(
                                "เข้าสู่ระบบ",
                                style: TextStyle(
                                  color: Colors.amber.shade600,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kanit',
                                ),
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _register(dynamic passwordController, dynamic confirmPasswordController) {
  String password = passwordController.text;
  String confirmPassword = confirmPasswordController.text;

  if (password == confirmPassword) {
    print("สมัครสมาชิกสำเร็จ");
    _showMessage("สมัครสมาชิกสำเร็จ");
  } else {
    print("รหัสผ่านไม่ตรงกัน");
    _showMessage("รหัสผ่านไม่ตรงกัน");
  }
}

// ฟังก์ชันสำหรับแสดงข้อความ
void _showMessage(String message) {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("ผลลัพธ์")),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(
            fontFamily: 'kanit', 
            fontSize: 20,
          ),
        ),
      ),
    ),
  ));
}

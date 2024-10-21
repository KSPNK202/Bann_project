import 'package:baan_app/employee/emp_login.dart';
import 'package:baan_app/manager/maj_login.dart';
import 'package:baan_app/user/pages/login.dart';
import 'package:flutter/material.dart';

class ChooseCarector extends StatefulWidget {
  const ChooseCarector({super.key});

  @override
  State<ChooseCarector> createState() => _ChooseCarectorState();
}

class _ChooseCarectorState extends State<ChooseCarector> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCC00),
        title: const Text(
          "เลือกบทบาท",
          style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn()));
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(40.0), 
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(10.0), 
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), 
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), 
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/admin_1.png",
                width: MediaQuery.of(context).size.width / 2.5,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              
              // กล่องสำหรับเลือกผู้จัดการร้าน
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MajLogin()), 
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5, 
                  margin: const EdgeInsets.symmetric(vertical: 10.0), 
                  padding: const EdgeInsets.symmetric(vertical: 15.0), 
                  decoration: BoxDecoration(
                    color: Colors.white, // เปลี่ยนสีพื้นหลังเป็นสีขาว
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.amber), 
                  ),
                  child: Text(
                    "ผู้จัดการร้าน",
                    style: TextStyle(
                      fontFamily: 'kanit',
                      fontSize: 18.0,
                      color: selectedRole == "ผู้จัดการร้าน" ? Colors.blue : Colors.black, // สีข้อความ
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "หรือ",
                style: TextStyle(
                  fontFamily: 'kanit',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 10),
              
              // กล่องสำหรับเลือกพนักงาน
              GestureDetector(
                onTap: () {
                  // นำทางไปยังหน้าพนักงาน
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmpLogin()), // เปลี่ยนเป็นหน้า EmployeePage ของคุณ
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5, // กำหนดความกว้างให้เป็น 50% ของหน้าจอ
                  margin: const EdgeInsets.symmetric(vertical: 10.0), // ช่องว่างระหว่างกล่อง
                  padding: const EdgeInsets.symmetric(vertical: 15.0), // ลด padding
                  decoration: BoxDecoration(
                    color: Colors.white, // เปลี่ยนสีพื้นหลังเป็นสีขาว
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.amber), // เปลี่ยนสีขอบเป็นสี Amber
                  ),
                  child: Text(
                    "พนักงาน",
                    style: TextStyle(
                      fontFamily: 'kanit',
                      fontSize: 18.0,
                      color: selectedRole == "พนักงาน" ? Colors.blue : Colors.black, // สีข้อความ
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                "images/admin_2.png",
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

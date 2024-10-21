
import 'package:baan_app/employee/emp_cus_info.dart';
import 'package:baan_app/employee/emp_login.dart';
import 'package:baan_app/employee/emp_recirpt.dart';
import 'package:baan_app/employee/foodemp.dart';
import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,

        title: Center(
          child: const Text(
            "ระบบพนักงาน",
            style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold),
          ),
        ),
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.amber), 
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const EmpLogin()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(2), 
                  child: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 18,
                    color: Colors.white,
                  ), 
                ),
                const SizedBox(width: 10),
                const Text(
                  "จัดการข้อมูลร้านอาหาร บ้านหลังเติบ",
                  style: TextStyle(fontFamily: 'kanit', fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FoodEmp()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)), 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/food_food.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10,),
                          const Text("เมนูอาหาร", style: TextStyle(fontFamily: 'kanit', fontSize: 16, fontWeight: FontWeight.normal),)
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20,),

                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EmpCusInfo()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/customer_baan.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10,),
                          const Text("ข้อมูลลูกค้า", style: TextStyle(fontFamily: 'kanit', fontSize: 16, fontWeight: FontWeight.normal),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EmpRecirpt()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)), 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/recirpt_baan.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10,),
                          const Text("ข้อมูลใบเสร็จ", style: TextStyle(fontFamily: 'kanit', fontSize: 16, fontWeight: FontWeight.normal),)
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20,),

                Flexible(
                  fit: FlexFit.tight,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
              ],
            ),

                const SizedBox(width: 20,),

                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   "images/admin_1.png",
                        //   height: 80,
                        //   width: 80,
                        //   fit: BoxFit.cover,
                        // ),
                        SizedBox(height: 10,),
                        //Text("ข้อมูลลูกค้า", style: TextStyle(fontFamily: 'kanit', fontSize: 16, fontWeight: FontWeight.normal),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          
          
        ),
      
    );
  }
}

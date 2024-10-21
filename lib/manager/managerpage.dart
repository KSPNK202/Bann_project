
import 'package:baan_app/manager/add_food.dart';
import 'package:baan_app/manager/cus_info.dart';
import 'package:baan_app/manager/foodmaj.dart';
import 'package:baan_app/manager/maj_login.dart';
import 'package:baan_app/manager/maj_recirpt.dart';
import 'package:baan_app/manager/maj_report.dart';
import 'package:baan_app/manager/receipt1.dart';
import 'package:baan_app/user/components/receipt.dart';
import 'package:flutter/material.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,

        title: Center(
          child: const Text(
            "ระบบผู้จัดการร้าน",
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
                MaterialPageRoute(builder: (context) => const MajLogin()),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FoodMaj()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/food_food.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "เมนูอาหาร",
                            style: TextStyle(
                                fontFamily: 'kanit',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddFood()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/menu_baan.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "แก้ไขรายการอาหาร",
                            style: TextStyle(
                                fontFamily: 'kanit',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
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
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CusInfo()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/customer_baan.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "ข้อมูลลูกค้า",
                            style: TextStyle(
                                fontFamily: 'kanit',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MajRecirpt()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/recirpt_baan.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "ข้อมูลใบเสร็จ",
                            style: TextStyle(
                                fontFamily: 'kanit',
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
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
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyWidget()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/report_baan.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            color: Colors.white
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "รายงานยอดขาย",
                            style: TextStyle(
                                fontFamily: 'kanit',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MajReport()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/report_baan.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "รายงานยอดขาย",
                            style: TextStyle(
                                fontFamily: 'kanit',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white
                                
                                ),
                          )
                        ],
                      ),
                      
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

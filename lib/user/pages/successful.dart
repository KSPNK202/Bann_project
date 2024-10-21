import 'package:baan_app/user/components/mybutton.dart';
import 'package:baan_app/user/components/receipt.dart';
import 'package:baan_app/user/models/database.dart';
import 'package:baan_app/user/models/restaurant.dart';
import 'package:baan_app/user/pages/bottomnav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({super.key});

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {

  FirestoreSevice db = FirestoreSevice();

  @override
  void initState() {
    super.initState();

    String receipt = context.read<Restaurant>().displayCartReceipt();
    db.saveOderToDatabase(receipt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text(
        //   "คำสั่งซื้อสำเร็จ..",
        //   style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold),
        // ),
      ),
      body: Column(
        children: [
          const Expanded( // ใช้ Expanded เพื่อให้ Column ขยายเต็มที่
            child: SingleChildScrollView( // ใช้ SingleChildScrollView เพื่อให้สามารถเลื่อนดูได้
              child: Column(
                children: [
                  Receipt(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0), // เพิ่มระยะห่าง
          MyButton(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNav()),
            ),
            text: "กลับสู่หน้าหลัก",
          ),
          const SizedBox(height: 25.0), // เพิ่มระยะห่าง
        ],
      ),
    );
  }
}

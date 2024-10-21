import 'package:flutter/material.dart';

class SuccessEmp extends StatelessWidget {
  final List<String> receipts; // เปลี่ยนเป็น List เพื่อเก็บหลายใบเสร็จ

  const SuccessEmp({Key? key, required this.receipts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สถานะการสั่งซื้อ', style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: receipts.length,
        itemBuilder: (context, index) {
          return Container( 
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), 
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber, width: 2), 
              borderRadius: BorderRadius.circular(8.0), 
              color: Colors.white, 
            ),
            child: ListTile(
              title: Text(
                'สถานะเสร็จสิ้น\nใบเสร็จ ${index + 1}: ${receipts[index]}',
                style: const TextStyle(
                  fontFamily: 'Kanit', 
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
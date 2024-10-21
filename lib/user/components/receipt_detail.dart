import 'package:flutter/material.dart';

class ReceiptDetail extends StatelessWidget {
  final String receipt;

  const ReceiptDetail({Key? key, required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดใบเสร็จ', style: TextStyle(fontFamily: 'kanit'),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            receipt,
            style: const TextStyle(fontSize: 16.0, fontFamily: 'kanit'),
          ),
        ),
      ),
    );
  }
}
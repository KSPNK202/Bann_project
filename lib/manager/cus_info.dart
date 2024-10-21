import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CusInfo extends StatefulWidget {
  const CusInfo({super.key});

  @override
  State<CusInfo> createState() => _CusInfoState();
}

class _CusInfoState extends State<CusInfo> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Future<List<Map<String, dynamic>>> customers;

  Future<List<Map<String, dynamic>>> fetchCustomers() async {
    QuerySnapshot snapshot = await firestore.collection('users').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  void initState() {
    super.initState();
    customers = fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลลูกค้า', style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: customers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No customers found.'));
          }

          final customerList = snapshot.data!;
          return ListView.builder(
            itemCount: customerList.length,
            itemBuilder: (context, index) {
              final customer = customerList[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 2), // กำหนดขอบเป็นสี amber
                  borderRadius: BorderRadius.circular(8.0), // ทำให้มุมของกรอบมน
                ),
                child: ListTile(
                  title: Text('${index + 1}. ${customer['ชื่อ']}'),
                  subtitle: Text('Email: ${customer['อีเมล']}\nPhone: ${customer['หมายเลขโทรศัพท์']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
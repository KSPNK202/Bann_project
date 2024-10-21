
import 'package:baan_app/manager/managerpage.dart';
import 'package:baan_app/user/components/receipt_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MajRecirpt extends StatefulWidget {
  const MajRecirpt({super.key});

  @override
  State<MajRecirpt> createState() => _MajRecirptState();
}

class _MajRecirptState extends State<MajRecirpt> {
  Future<List<Map<String, dynamic>>> _fetchOrdersFromFirebase() async {
    final snapshot = await FirebaseFirestore.instance.collection('orders').get();
    final orders = snapshot.docs.map((doc) {
      final receiptData = doc.data();
      return {
        'date': receiptData['date'], // ดึงวันที่จาก Firestore
        'order': receiptData['order'], // ดึงใบเสร็จจาก Firestore
      };
    }).toList();
    return orders; // คืนค่ารายการที่มีวันที่และใบเสร็จ
  }

  Future<void> _deleteAllOrders() async {
    final snapshot = await FirebaseFirestore.instance.collection('orders').get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    setState(() {}); // Refresh the state to update the UI
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'ยืนยันการลบ',
            style: TextStyle(fontFamily: 'kanit'), 
          ),
          content: const Text(
            'คุณแน่ใจหรือว่าต้องการลบใบเสร็จทั้งหมด?',
            style: TextStyle(fontFamily: 'kanit'), 
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text(
                'ยกเลิก',
                style: TextStyle(fontFamily: 'kanit'), 
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteAllOrders();
                Navigator.of(context).pop(); 
              },
              child: const Text(
                'ยืนยัน',
                style: TextStyle(fontFamily: 'kanit'), 
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ใบเสร็จร้านค้า',
          style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ManagerPage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete), 
            onPressed: _showDeleteConfirmationDialog, 
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchOrdersFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.amber,
                      width: 2.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ListTile(
                        // title: Text(
                        //    'วันที่: ${order['date'] ?? 'ไม่มีวันที่'}', // แสดงวันที่
                        //   style: const TextStyle(fontFamily: 'kanit'), 
                        // ),
                        subtitle: Text(
                          order['order'], // แสดงใบเสร็จ
                          style: const TextStyle(fontFamily: 'kanit'), 
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReceiptDetail(receipt: order['order']),
                            ),
                          );
                        },
                      ),
                      const Positioned(
                        right: 8.0,
                        top: 8.0,
                        child: Icon(
                          Icons.receipt, 
                          color: Colors.black, 
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
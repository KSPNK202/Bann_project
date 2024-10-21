import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MajReport extends StatefulWidget {
  const MajReport({super.key});

  @override
  State<MajReport> createState() => _MajReportState();
}

class _MajReportState extends State<MajReport> {
  List<double> monthlySales =
      List.filled(12, 0); // สร้างรายชื่อสำหรับยอดขาย 12 เดือน

  @override
  void initState() {
    super.initState();
    _calculateMonthlySales();
  }

  Future<void> _calculateMonthlySales() async {
    try {
      final orders =
          await _fetchOrdersFromFirebase(); // ดึงข้อมูลใบเสร็จจาก Firestore
      for (var order in orders) {
        if (order['date'] != null && order['totalPrice'] != null) {
          DateTime date =
              DateTime.parse(order['date']); // แปลงวันที่เป็น DateTime
          int month = date.month - 1; // เดือนเริ่มต้นที่ 0
          monthlySales[month] += order['totalPrice']; // เพิ่มยอดขายในเดือนนั้น
        } else {
          // จัดการกรณีที่ข้อมูลไม่ถูกต้อง
          print('ข้อมูลไม่ถูกต้อง: ${order['date']}, ${order['totalPrice']}');
        }
      }
      setState(() {}); // Refresh the state to update the UI
    } catch (e) {
      print("Error fetching orders: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ไม่สามารถดึงข้อมูลยอดขายได้')),
      );
    }
  }

  Future<List<Map<String, dynamic>>> _fetchOrdersFromFirebase() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('orders').get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายงานยอดขายประจำเดือน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 38,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text('Jan');
                      case 1:
                        return const Text('Feb');
                      case 2:
                        return const Text('Mar');
                      case 3:
                        return const Text('Apr');
                      case 4:
                        return const Text('May');
                      case 5:
                        return const Text('Jun');
                      case 6:
                        return const Text('Jul');
                      case 7:
                        return const Text('Aug');
                      case 8:
                        return const Text('Sep');
                      case 9:
                        return const Text('Oct');
                      case 10:
                        return const Text('Nov');
                      case 11:
                        return const Text('Dec');
                      default:
                        return const Text('');
                    }
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            gridData: const FlGridData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(monthlySales.length,
                    (index) => FlSpot(index.toDouble(), monthlySales[index])),
                isCurved: true,
                color: Colors.blue,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

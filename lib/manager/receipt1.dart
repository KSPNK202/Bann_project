import 'package:baan_app/user/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Map<String, double> monthlySales = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMonthlySales();
  }

  Future<void> fetchMonthlySales() async {
    setState(() {
      isLoading = true; // เริ่มโหลดข้อมูล
    });

    try {
      final restaurant = Provider.of<Restaurant>(context, listen: false);
      monthlySales = await restaurant.calculateMonthlySalesReport();
    } catch (e) {
      print("Error fetching monthly sales: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ไม่สามารถดึงข้อมูลยอดขายได้')),
      );
    } finally {
      setState(() {
        isLoading = false; // เสร็จสิ้นการโหลดข้อมูล
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายงานยอดขายประจำเดือน'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchMonthlySales, // เพิ่มปุ่มรีเฟรช
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : monthlySales.isEmpty
              ? const Center(child: Text('ไม่มีข้อมูลยอดขาย'))
              : ListView.builder(
                  itemCount: monthlySales.length,
                  itemBuilder: (context, index) {
                    String monthYear = monthlySales.keys.elementAt(index);
                    double totalSales = monthlySales[monthYear]!;
                    return ListTile(
                      title: Text('$monthYear: ${_formatPrice(totalSales)}'),
                    );
                  },
                ),
    );
  }

  String _formatPrice(double price) {
    return "${price.toStringAsFixed(2)} บาท";
  }
}

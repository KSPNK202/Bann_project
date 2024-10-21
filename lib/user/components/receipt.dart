import 'package:baan_app/user/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "ร้านอาหารบ้านหลังเติบ",
              style: TextStyle(
                  fontFamily: 'kanit',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
            const Text(
              "ขอบคุณสำหรับคำสั่งซื้อ... ทานให้อร่อย",
              style: TextStyle(
                fontFamily: 'kanit',
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(25),
              child: Consumer<Restaurant>(
                builder: (context, restaurant, child) => Text(
                  restaurant.displayCartReceipt(),
                  style: const TextStyle(fontFamily: 'kanit'),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "สามารถใช้บริการร้านได้ตั้งแต่เวลา 9.00 น. - 18.00 น.",
              style: TextStyle(fontFamily: 'kanit'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:baan_app/user/components/cart_tile.dart';
import 'package:baan_app/user/components/mybutton.dart';
import 'package:baan_app/user/models/restaurant.dart';
import 'package:baan_app/user/pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;

        // รายการจำนวนคน
        List<int> numberOfPeopleOptions = List.generate(8, (index) => index + 1);

        // รายการเวลา
        List<String> timeOptions = [
          for (int hour = 9; hour <= 18; hour++)
            "${hour.toString().padLeft(2, '0')}:00 น."
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "ตระกร้าสินค้า",
              style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "คุณต้องการนำสิ้นค้าทั้งหมดออกใช่มั้ย?",
                        style: TextStyle(fontFamily: 'kanit'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "ยกเลิก",
                            style: TextStyle(fontFamily: 'kanit'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text(
                            "ตกลง",
                            style: TextStyle(fontFamily: 'kanit'),
                          ),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
          body: Column(
            children: [
              // Dropdown for table selection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "เลือกโต๊ะ",
                      style: TextStyle(
                        fontFamily: 'kanit',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: restaurant.selectedTable,
                      hint: const Text(
                        "เลือกโต๊ะ   ",
                        style: TextStyle(fontFamily: 'kanit'),
                      ),
                      items: restaurant.tables.map((table) {
                        return DropdownMenuItem<String>(
                          value: table['name'],
                          child: Text(
                            table['name'],
                            style: const TextStyle(fontFamily: 'kanit'),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          restaurant.selectTable(value); // เรียกใช้ selectTable โดยส่งชื่อโต๊ะ
                        }
                      },
                    ),
                  ],
                ),
              ),

              // Dropdown for number of people
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ระบุจำนวนคน:",
                      style: TextStyle(
                        fontFamily: 'kanit',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<int>(
                      value: restaurant.selectedNumberOfPeople,
                      hint: const Text(
                        "              คน",
                        style: TextStyle(fontFamily: 'kanit'),
                      ),
                      items: numberOfPeopleOptions.map((int number) {
                        return DropdownMenuItem<int>(
                          value: number,
                          child: Text(
                            number.toString(),
                            style: const TextStyle(fontFamily: 'kanit'),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          restaurant.setNumberOfPeople(value);
                        }
                      },
                    ),
                  ],
                ),
              ),

              // Dropdown for time selection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "เลือกเวลา:",
                      style: TextStyle(
                        fontFamily: 'kanit',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: restaurant.selectedTime,
                      hint: const Text(
                        "เลือกเวลา   ",
                        style: TextStyle(fontFamily: 'kanit'),
                      ),
                      items: timeOptions.map((String time) {
                        return DropdownMenuItem<String>(
                          value: time,
                          child: Text(
                            time,
                            style: const TextStyle(fontFamily: 'kanit'),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          restaurant.setTime(value);
                        }
                      },
                    ),
                  ],
                ),
              ),

              // List of cart
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text(
                                "ตระกร้าว่าง..",
                                style: TextStyle(
                                    fontFamily: 'kanit', fontSize: 18.0),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                final cartItem = userCart[index];

                                return CartTile(cartItem: cartItem);
                              },
                            )),
                  ],
                ),
              ),

              // แสดงจำนวนสินค้า
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "จำนวนสินค้า : ${restaurant.getTotalItemCount()}",
                      style: const TextStyle(
                        fontFamily: 'kanit',
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),

              // แสดงผลรวมราคา
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "รวมทั้งหมด:",
                      style: TextStyle(
                        fontFamily: 'kanit',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${restaurant.getTotalPrice().toStringAsFixed(0)} บาท',
                      style: const TextStyle(
                        fontFamily: 'kanit',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5.0),

              // Button to pay
              MyButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PayMent()),
                ),
                text: "ชำระเงิน",
              ),

              const SizedBox(height: 25.0),
            ],
          ),
        );
      },
    );
  }
}
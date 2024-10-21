import 'package:baan_app/user/components/mybutton.dart';
import 'package:baan_app/user/pages/successful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PayMent extends StatefulWidget {
  const PayMent({super.key});

  @override
  State<PayMent> createState() => _PayMentState();
}

class _PayMentState extends State<PayMent> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("ยืนยันการชำระ", style: TextStyle(fontFamily: 'kanit')),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number : $cardNumber", style: const TextStyle(fontFamily: 'kanit')),
                Text("Expiry Date : $expiryDate", style: const TextStyle(fontFamily: 'kanit')),
                Text("Card Holder name : $cardHolderName", style: const TextStyle(fontFamily: 'kanit')),
                Text("CVV : $cvvCode", style: const TextStyle(fontFamily: 'kanit')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ยกเลิก", style: TextStyle(fontFamily: 'kanit')),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SuccessfulPage()),
              ),
              child: const Text("ตกลง", style: TextStyle(fontFamily: 'kanit')),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "ชำระเงิน",
          style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded( // ใช้ Expanded เพื่อให้ Column ขยายเต็มที่
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    onCreditCardWidgetChange: (p0) {},
                  ),
                  CreditCardForm(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    onCreditCardModelChange: (data) {
                      setState(() {
                        cardNumber = data.cardNumber;
                        expiryDate = data.expiryDate;
                        cardHolderName = data.cardHolderName;
                        cvvCode = data.cvvCode;
                      });
                    },
                    formKey: formKey,
                  ),
                ],
              ),
            ),
          ),
          // ปุ่มชำระเงินอยู่ที่นี่
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15), // เพิ่ม padding
            width: double.infinity, // ให้กว้างเต็มที่
            child: MyButton(
              onTap: userTappedPay,
              text: "ชำระเงิน",
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:baan_app/widget/widget_support.dart';
import 'package:baan_app/user/pages/cartpage.dart';
import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        IconButton(
          onPressed: () {
            // ใช้ Navigator เพื่อไปยัง CartPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Container(
        alignment: Alignment.center, // จัดตำแหน่งข้อความให้ตรงกลาง
        child: Text(
          "บ้านหลังเติบ",
          style: AppWidget.HeadlineTextFeildStyle(), // ตรวจสอบให้แน่ใจว่าฟังก์ชันนี้ถูกต้อง
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}
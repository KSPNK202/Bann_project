import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 24.0, // กำหนดขนาดของไอคอน
          ),
          SizedBox(width: 8.0), // เพิ่มระยะห่างระหว่างไอคอนและ TextField
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ค้นหาเมนู...',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Kanit',
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
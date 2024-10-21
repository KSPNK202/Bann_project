import 'package:baan_app/widget/widget_support.dart';
import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 65.0,
          ),
          const SizedBox(width: 16.0), 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "สวัสดี!",
                style: AppWidget.HeadlineTextFeildStyle(),
              ),
              Text(
                "มาเริ่มต้นเมนูของคุณกันเลย..",
                style: AppWidget.LightTextFeildStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
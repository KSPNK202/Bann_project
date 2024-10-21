import 'package:baan_app/user/models/food.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                // text food details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'kanit'),
                      ),
                      Text(
                        '${food.price} บาท',
                        style: TextStyle(
                          color: Colors.amber.shade700,
                          fontSize: 16.0,
                          fontFamily: 'kanit',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        food.description,
                        style: const TextStyle(
                          fontFamily: 'kanit',
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 15,
                ),

                // food image
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(food.imagePath, height: 120)),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.black12,
          endIndent: 10,
          indent: 10,
        )
      ],
    );
  }
}

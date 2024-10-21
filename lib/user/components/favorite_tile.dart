import 'package:baan_app/user/models/food.dart';
import 'package:flutter/material.dart';

class FavoriteTile extends StatelessWidget {
  final Food favoriteItem;

  const FavoriteTile({super.key, required this.favoriteItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              favoriteItem.imagePath,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favoriteItem.name,
                    style: const TextStyle(
                      fontFamily: 'kanit',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${favoriteItem.price} บาท',
                    style: const TextStyle(
                      fontFamily: 'kanit',
                      fontSize: 16.0,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
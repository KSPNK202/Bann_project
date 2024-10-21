import 'package:baan_app/user/models/restaurant.dart';
import 'package:baan_app/user/pages/bottomnav.dart';
import 'package:baan_app/user/pages/foodpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<Restaurant>().favorites; 

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNav()),); 
          },
        ),
        title: const Text(
          "รายการโปรด",
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete), 
            onPressed: () {
              
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("ยืนยันการลบ"),
                  content: const Text("คุณต้องการลบรายการโปรดทั้งหมดหรือไม่?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: const Text("ยกเลิก"),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<Restaurant>()
                            .clearFavorites(); 
                        Navigator.pop(context); 
                      },
                      child: const Text("ตกลง"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "ไม่มีรายการโปรด",
                style: TextStyle(
                  fontFamily: 'kanit',
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final food = favorites[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber), 
                  ),
                  child: ListTile(
                    title: Text(
                      food.name,
                      style: const TextStyle(
                        fontFamily: 'kanit',
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      '${food.price} บาท',
                      style: const TextStyle(
                        fontFamily: 'kanit',
                        fontSize: 16,
                      ),
                    ),
                    leading: Image.asset(food.imagePath, width: 50, height: 50),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite,
                          color: Colors.red), 
                      onPressed: () {
                        context
                            .read<Restaurant>()
                            .removeFromFavorites(food); 
                      },
                    ),
                    onTap: () {
                      // Handle tap on favorite item
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodPage(food: food),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}


import 'package:baan_app/manager/managerpage.dart';
import 'package:baan_app/user/components/food_tile.dart';
import 'package:baan_app/user/components/tab_bar.dart';
import 'package:baan_app/user/models/food.dart';
import 'package:baan_app/user/models/restaurant.dart';
import 'package:baan_app/user/pages/foodpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodMaj extends StatefulWidget { // Changed class name here
  const FoodMaj({super.key}); // Changed constructor name here

  @override
  State<FoodMaj> createState() => _FoodMajState(); // Changed state class name here
}

class _FoodMajState extends State<FoodMaj> with SingleTickerProviderStateMixin { // Changed state class name here
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FoodCategory.values.length, vsync: this);
    
    // Fetch menu data from Firebase
    final restaurant = Provider.of<Restaurant>(context, listen: false);
    restaurant.fetchMenuFromFirebase();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodPage(food: food),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.amber,
      title: const Text(
        "รายการอาหาร",
        style: TextStyle(fontFamily: 'kanit', fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ManagerPage()),
          );
        },
      ),
    ),
    body: Column(
      children: [
        MyTabbar(tabController: _tabController), // TabBar สำหรับหมวดหมู่
        Expanded(
          child: Consumer<Restaurant>(
            builder: (context, restaurant, child) {
              return TabBarView(
                controller: _tabController,
                children: getFoodInThisCategory(restaurant.menu),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}
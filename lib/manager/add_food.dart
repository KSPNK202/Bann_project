import 'package:baan_app/manager/managerpage.dart';
import 'package:baan_app/user/models/food.dart';
import 'package:baan_app/user/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _description;
  double? _price;
  String? _imagePath;
  FoodCategory? _category; // หมวดหมู่ของอาหาร

  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<Restaurant>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "เพิ่มรายการอาหาร",
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
      body: SingleChildScrollView( // เพิ่ม SingleChildScrollView ที่นี่
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Minimize the size of the column
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ชื่ออาหาร',
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        style: const TextStyle(fontFamily: 'kanit'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกชื่ออาหาร';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'รายละเอียด',
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        style: const TextStyle(fontFamily: 'kanit'),
                        onSaved: (value) {
                          _description = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ราคา',
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontFamily: 'kanit'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกราคา';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _price = double.tryParse(value!);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'เส้นทางรูปภาพ',
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        style: const TextStyle(fontFamily: 'kanit'),
                        onSaved: (value) {
                          _imagePath = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: DropdownButtonFormField<FoodCategory>(
                        decoration: const InputDecoration(
                          labelText: 'หมวดหมู่',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10),
                        ),
                        style:
                            const TextStyle(fontFamily: 'kanit'),
                        items:
                            FoodCategory.values.map((FoodCategory category) {
                          return DropdownMenuItem(
                            value: category,
                            child:
                                Text(category.toString().split('.').last,
                                    style:
                                        const TextStyle(fontFamily:
                                            'kanit', color:
                                            Colors.black)),
                          );
                        }).toList(),
                        onChanged:(value) {
                          setState(() {
                            _category = value;
                          });
                        },
                        validator:(value) {
                          if (value == null) {
                            return 'กรุณาเลือกหมวดหมู่';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:(() {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // สร้าง Food object
                          Food newFood = Food(
                            name:_name!,
                            description:_description ?? '',
                            imagePath:_imagePath ?? '',
                            price:_price ?? 0,
                            category:_category!,
                            availableAddons:[]
                          );

                          // เพิ่มอาหารใหม่ไปยัง restaurant
                          restaurant.addFood(newFood);

                          // กลับไปที่หน้าหลัก
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) =>const ManagerPage()));
                        }
                      }),
                      style:
                          ElevatedButton.styleFrom(foregroundColor:
                              Colors.black, shape:
                              RoundedRectangleBorder(borderRadius:
                                  BorderRadius.circular(20), side:
                                  const BorderSide(color:
                                      Colors.amber, width:
                                      2))),
                      child:
                          const Text('เพิ่มอาหาร', style:
                              TextStyle(fontFamily:'kanit', fontSize:
                                  20, fontWeight:
                                  FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
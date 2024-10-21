import 'package:baan_app/user/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:baan_app/user/components/mybutton.dart';
import 'package:baan_app/user/models/food.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectAddons = {};
  bool isFavorite = false;

  FoodPage({super.key, required this.food}) {
    for (Addon addon in food.availableAddons) {
      selectAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int quantity = 1;

  double getTotalPrice() {
    double total = widget.food.price.toDouble() * quantity;

    widget.selectAddons.forEach((addon, isSelected) {
      if (isSelected) {
        total += addon.price;
      }
    });

    return total;
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  // method to add to cart
  void addToCart(Food food, Map<Addon, bool> selectAddons) {
    Navigator.pop(context);

    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }

    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'รายละเอียดอาหาร',
          style: TextStyle(fontFamily: 'kanit'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                widget.isFavorite = !widget.isFavorite; 
                if (widget.isFavorite) {
                  context.read<Restaurant>().addToFavorites(widget.food); 
                } else {
                  context.read<Restaurant>().removeFromFavorites(widget.food);
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InteractiveViewer(
                    child: SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Image.asset(
                        widget.food.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.food.name,
                            style: const TextStyle(
                                fontSize: 24,
                                fontFamily: 'kanit',
                                fontWeight: FontWeight.bold)),
                        Text('${widget.food.price} บาท',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'kanit',
                              color: Colors.amber,
                            )),
                        const SizedBox(height: 10.0),
                        Text(widget.food.description,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'kanit',
                              color: Colors.black54,
                            )),
                        const SizedBox(height: 15.0),
                        // const Divider(color: Colors.black12),
                        // const Text("เพิ่มเติม",
                        //     style: TextStyle(
                        //         fontSize: 16,
                        //         fontFamily: 'kanit',
                        //         fontWeight: FontWeight.bold)),
                        // const SizedBox(height: 5.0),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: widget.food.availableAddons.length,
                            itemBuilder: (context, index) {
                              Addon addon = widget.food.availableAddons[index];
                              return CheckboxListTile(
                                title: Text(
                                  addon.name,
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'kanit'),
                                ),
                                subtitle: Text(
                                  '${addon.price} บาท',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'kanit',
                                    color: Colors.amber,
                                  ),
                                ),
                                value: widget.selectAddons[addon],
                                onChanged: (bool? value) {
                                  setState(() {
                                    widget.selectAddons[addon] = value!;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black12),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ส่วนเพิ่มจำนวนสินค้า
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove, size: 20),
                        onPressed: decreaseQuantity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: increaseQuantity,
                      ),
                    ),
                  ],
                ),
                // ปุ่มเพิ่มลงตระกร้า
                MyButton(
                  onTap: () => addToCart(widget.food, widget.selectAddons),
                  text: "  ใส่ตะกร้า  ${getTotalPrice()} บาท",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

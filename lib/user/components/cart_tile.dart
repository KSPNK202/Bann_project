import 'package:baan_app/user/components/quantity_selector.dart';
import 'package:baan_app/user/models/cart_item.dart'; // ตรวจสอบว่าไฟล์นี้มีอยู่จริง
import 'package:baan_app/user/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartItem cartItem;

  const CartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
            color: Colors.amber.shade200,
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItem.food.imagePath,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.food.name,
                        style: const TextStyle(
                            fontFamily: 'kanit',
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        ('${cartItem.food.price}\ บาท'),
                        style: const TextStyle(
                            fontFamily: 'kanit',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  QuantitySelector(
                      quantity: cartItem.quantity,
                      food: cartItem.food,
                      onDecrement: () {
                        restaurant.removeFromCart(cartItem);
                      },
                      onIncrement: () {
                        restaurant.addToCart(
                            cartItem.food, cartItem.selectAddons);
                      })
                ],
              ),
            ),
            SizedBox(
              height: cartItem.selectAddons.isEmpty ? 0 : 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                children: cartItem.selectAddons
                    .map(
                      (addon) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Row(
                            children: [
                              Text(addon.name),
                              Text(' (${addon.price} บาท)'),
                            ],
                          ),
                          shape: const StadiumBorder(
                            side: BorderSide(
                              color: Colors.black,
                            )
                          ),
                          onSelected: (value) {},
                          backgroundColor: Colors.white,
                          labelStyle: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontFamily: 'kanit',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}



// import 'package:baan_app/components/quantity_selector.dart';
// import 'package:baan_app/models/cart_item.dart'; // ตรวจสอบว่าไฟล์นี้มีอยู่จริง
// import 'package:baan_app/models/restaurant.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CartTile extends StatelessWidget {
//   final CartItem cartItem;

//   const CartTile({super.key, required this.cartItem});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Restaurant>(
//       builder: (context, restaurant, child) => Container(
//         decoration: BoxDecoration(
//             color: Colors.amber.shade200,
//             borderRadius: BorderRadius.circular(8)),
//         margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.asset(
//                       cartItem.food.imagePath,
//                       height: 100,
//                       width: 100,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10.0,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         cartItem.food.name,
//                         style: TextStyle(
//                             fontFamily: 'kanit',
//                             fontSize: 16,
//                             fontWeight: FontWeight.normal),
//                       ),
//                       Text(
//                         (cartItem.food.price.toString() + '\ บาท'),
//                         style: TextStyle(
//                             fontFamily: 'kanit',
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   QuantitySelector(
//                       quantity: cartItem.quantity,
//                       food: cartItem.food,
//                       onDecrement: () {
//                         restaurant.removeFromCart(cartItem);
//                       },
//                       onIncrement: () {
//                         restaurant.addToCart(
//                             cartItem.food, cartItem.selectAddons);
//                       })
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: cartItem.selectAddons.isEmpty ? 0 : 60,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
//                 children: cartItem.selectAddons
//                     .map(
//                       (addon) => Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: FilterChip(
//                           label: Row(
//                             children: [
//                               Text(addon.name),
//                               Text(' (${addon.price}\ บาท)'),
//                             ],
//                           ),
//                           shape: StadiumBorder(
//                             side: BorderSide(
//                               color: Colors.black,
//                             )
//                           ),
//                           onSelected: (value) {},
//                           backgroundColor: Colors.white,
//                           labelStyle: TextStyle(
//                             color: Colors.black87,
//                             fontSize: 12,
//                             fontFamily: 'kanit',
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

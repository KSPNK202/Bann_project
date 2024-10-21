import 'dart:math';
import 'package:baan_app/user/models/cart_item.dart';
import 'package:baan_app/user/models/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'food.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [];

  //  G E T T E R S
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  // User cart
  final List<CartItem> _cart = [];

  // User favorites
  final List<Food> _favorites = [];
  List<Food> _filteredMenu = [];

  List<Food> get favorites => _favorites;

  // Add to cart
  void addToCart(Food food, List<Addon> selectAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons =
          const ListEquality().equals(item.selectAddons, selectAddons);
      return isSameFood && isSameAddons;
    });

    // If item already exists, increase its quantity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectAddons: selectAddons));
    }
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // Get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // Get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // Add food to menu and save to Firebase
  void addFood(Food food) {
    _menu.add(food);
    saveMenuToFirebase(); // Save to Firebase
    notifyListeners(); // Notify UI to update
  }

  // Save menu to Firebase
  Future<void> saveMenuToFirebase() async {
    CollectionReference foodCollection =
        FirebaseFirestore.instance.collection('menu');

    for (var food in _menu) {
      List<Map<String, dynamic>> addonsData = food.availableAddons.map((addon) {
        return {
          'name': addon.name,
          'price': addon.price,
        };
      }).toList();

      await foodCollection.add({
        'name': food.name,
        'description': food.description,
        'imagePath': food.imagePath,
        'price': food.price,
        'category': food.category.toString(),
        'availableAddons': addonsData,
      });
    }
  }

  // Fetch menu from Firebase
  Future<void> fetchMenuFromFirebase() async {
    CollectionReference foodCollection =
        FirebaseFirestore.instance.collection('menu');
    QuerySnapshot snapshot = await foodCollection.get();

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;

      // ตรวจสอบว่าเมนูนี้มีอยู่ใน _menu หรือไม่
      bool exists = _menu.any((food) => food.name == data['name']);

      if (!exists) {
        Food food = Food(
          name: data['name'],
          description: data['description'],
          imagePath: data['imagePath'],
          price: data['price'],
          category: FoodCategory.values
              .firstWhere((e) => e.toString() == data['category']),
          availableAddons: (data['availableAddons'] as List).map((addon) {
            return Addon(name: addon['name'], price: addon['price']);
          }).toList(),
        );
        _menu.add(food); // เพิ่มเมนูใหม่เข้าไป
      }
    }
    notifyListeners(); // แจ้งเตือน UI เพื่ออัปเดต
  }

  // Remove food from menu
  void removeFood(Food food) {
    _menu.remove(food);
    notifyListeners(); // Notify UI to update
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Favorites operations
  void addToFavorites(Food food) {
    if (!_favorites.contains(food)) {
      _favorites.add(food);
      notifyListeners();
    }
  }

  void removeFromFavorites(Food food) {
    _favorites.remove(food);
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }

// receipt
  String _generateReceiptNumber() {
    Random random = Random();
    int receiptNumber = random.nextInt(90000) + 10000;
    return receiptNumber.toString();
  }

  Future<List<Map<String, dynamic>>> _fetchOrdersFromFirebase() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .orderBy('date', descending: true) // เรียงลำดับตามวันที่จากใหม่ไปเก่า
        .get();

    final orders = snapshot.docs.map((doc) {
      final receiptData = doc.data();
      return {
        'date': (receiptData['date'] as Timestamp)
            .toDate(), // แปลง Timestamp เป็น DateTime
        'order': receiptData['order'],
        'totalPrice': receiptData['totalPrice'],
      };
    }).toList();

    return orders; // คืนค่ารายการที่มีวันที่และใบเสร็จ
  }

  String displayCartReceipt() {
    final receipt = StringBuffer();
    String receiptNumber = _generateReceiptNumber();
    receipt.writeln("ใบเสร็จ");
    receipt.writeln("เลขที่ใบเสร็จ: $receiptNumber");
    receipt.writeln();

    String formattedDate = DateFormat('วันที่ dd/MM/yyyy     เวลา HH:mm น.')
        .format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------------------------------");

    receipt.writeln("โต๊ะที่จอง: ${selectedTable ?? 'ไม่ระบุ'}");
    receipt.writeln("จำนวนคน: $selectedNumberOfPeople");
    receipt.writeln("เวลา: ${selectedTime ?? 'ไม่ระบุ'}");
    receipt.writeln("-----------------------------------");
    receipt.writeln();

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity}       ${(cartItem.food.name)} - ${_formatPrice(cartItem.food.price * cartItem.quantity)}");
      if (cartItem.selectAddons.isNotEmpty) {
        receipt
            .writeln("    เพิ่มเติม: ${_formatAddons(cartItem.selectAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("-----------------------------------");
    receipt.writeln();
    receipt.writeln("รวมทั้งหมด : ${getTotalItemCount()} ชิ้น");
    receipt.writeln("รวมราคาทั้งหมด : ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "${price.toStringAsFixed(2)} บาท";
  }

  String _formatAddons(List<Addon> addon) {
    return addon
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }

  final List<Map<String, dynamic>> _tables = [
    {'name': "สั่งกลับบ้าน", 'isSelected': false},
    {'name': "โต๊ะ 1 ที่นั่ง", 'isSelected': false},
    {'name': "โต๊ะ 4 ที่นั่ง", 'isSelected': false},
    {'name': "โต๊ะ 6 ที่นั่ง", 'isSelected': false},
    {'name': "โต๊ะ 8 ที่นั่ง", 'isSelected': false},
  ];

  // จำนวนคนs
  int selectedNumberOfPeople = 1; // จำนวนคนเริ่มต้น
  String? selectedTime; // เวลาเริ่มต้น

  // รายการที่ถูกเลือก
  List<Map<String, dynamic>> get tables => _tables;
  String? selectedTable;

  void selectTable(String tableName) {
    selectedTable = tableName; // เก็บโต๊ะที่เลือก
    // ยกเลิกการเลือกโต๊ะทั้งหมดก่อน
    for (var table in _tables) {
      table['isSelected'] = false;
    }
    // ตั้งค่าโต๊ะที่เลือก
    _tables.firstWhere((table) => table['name'] == tableName)['isSelected'] =
        true;
    notifyListeners(); // แจ้งเตือนให้ UI อัพเดท
  }

  void setNumberOfPeople(int number) {
    selectedNumberOfPeople = number;
    notifyListeners();
  }

  void setTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  Future<Map<String, double>> calculateMonthlySalesReport() async {
    final orders = await _fetchOrdersFromFirebase();
    Map<String, double> monthlySales = {};

    for (var order in orders) {
      DateTime date = order['date'];
      String monthYear = DateFormat('MM/yyyy').format(date);

      // สร้างรายการ CartItem จากข้อมูลในคำสั่งซื้อ
      List<CartItem> orderItems = [];
      for (var item in order['order']) {
        Food food = Food(
          name: item['name'],
          description: item['description'],
          imagePath: item['imagePath'],
          price: item['price'],
          category: FoodCategory.values
              .firstWhere((e) => e.toString() == item['category']),
          availableAddons: (item['availableAddons'] as List).map((addon) {
            return Addon(name: addon['name'], price: addon['price']);
          }).toList(),
        );

        CartItem cartItem = CartItem(food: food, selectAddons: []);
        orderItems.add(cartItem);
      }

      // คำนวณยอดรวมของคำสั่งซื้อนั้น
      double totalPrice = getTotalPriceFromItems(orderItems);

      if (monthlySales.containsKey(monthYear)) {
        monthlySales[monthYear] = monthlySales[monthYear]! + totalPrice;
      } else {
        monthlySales[monthYear] = totalPrice;
      }
    }

    return monthlySales; // คืนค่ารายงานยอดขายประจำเดือน
  }

  double getTotalPriceFromItems(List<CartItem> items) {
    double total = 0.0;

    for (CartItem cartItem in items) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectAddons) {
        itemTotal += addon.price;
      }

      total +=
          itemTotal; // ไม่คูณด้วย quantity เพราะถือว่ารายการนี้เป็นคำสั่งซื้อเต็มจำนวน
    }

    return total;
  }
}

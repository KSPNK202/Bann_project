import 'package:baan_app/user/pages/favorite.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:baan_app/user/pages/home.dart';
import 'package:baan_app/user/pages/profile.dart';
import 'package:baan_app/user/pages/order.dart';
//import 'package:baan_app/pages/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex=0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late Profile profile;
  late Order order;
  late Favorite favorite;
  //late Wallet wallet;

  @override
  void initState(){
    homepage=const Home();
    order=const Order();
    profile=const Profile();
    //wallet=const Wallet();
    favorite=const Favorite();
    pages=[homepage, favorite, order, profile];
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: const Color(0xFFFFCC00),
        color: Colors.white,
        animationDuration: const Duration(microseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
          });
        },
        items:const [
        Icon(
          Icons.home_outlined,
          color: Colors.black,
        ),
        Icon(
          Icons.favorite_outline_rounded,
          color: Colors.black,
        ),
        Icon(
          Icons.history,
          color: Colors.black,
        ),
        // Icon(
        //   Icons.wallet_outlined,
        //   color: Colors.black,
        // ),
        Icon(
          Icons.person_outline,
          color: Colors.black,
        )
      ]),
      body: pages[currentTabIndex],
    );
  }
}
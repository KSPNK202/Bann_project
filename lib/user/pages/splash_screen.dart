
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;
  const SplashScreen({super.key, required this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000)).then((value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child), (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFCC00),
      body: Center(
        child: Image.asset("images/restaurant_logo.png",
        width: 250, 
        height: 250, 
        fit: BoxFit.contain,
        ),
      ),
    );
  }
}

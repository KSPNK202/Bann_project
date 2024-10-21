import 'package:baan_app/user/models/restaurant.dart';
import 'package:baan_app/user/pages/onboarding_screen.dart';
import 'package:baan_app/user/pages/splash_screen.dart';
import 'package:baan_app/user/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (context) => Restaurant()), // มีการเพิ่ม Restaurant ที่นี่
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primarySwatch = MaterialColor(
      0xFFFFCC00,
      <int, Color>{
        50: Color(0xFFFFFDE7),
        100: Color(0xFFFFE5B2),
        200: Color(0xFFFFD54F),
        300: Color(0xFFFFCA28),
        400: Color(0xFFFFC107),
        500: Color(0xFFFFEB3B),
        600: Color(0xFFFBC02D),
        700: Color(0xFFF9A825),
        800: Color(0xFFF57F17),
        900: Color(0xFFF57F17),
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baan APP',
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: const SplashScreen(child: OnBoardingScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project/Screens/welcomePage.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'item.dart';
// void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFF9BC1F),
          secondary: const Color(0xFFFFE9B1),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

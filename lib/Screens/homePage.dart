import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/Screens/recomPage.dart';
import 'package:project/Screens/nearbyPage.dart';
import 'package:project/Screens/profilePage.dart';
import 'package:project/Screens/searchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var Index = 0;
  List widgetoptions = [
    const RecommendPage(),
    const SearchPage(),
    const NearbyPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: widgetoptions[Index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: const Color(0xFFF4E9CE), // <-- This works for fixed
        selectedItemColor: const Color(0xffd86c00),
        unselectedItemColor: const Color(0xffdfa000),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Nearby',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userAlt),
            label: 'Profile',
          ),
        ],
        currentIndex: Index,
        onTap: (value) => setState(() => Index = value),
      ),
    );
  }
}

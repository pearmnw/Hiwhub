import 'package:flutter/material.dart';
import 'loginPage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/bg/EllipseTop.png',
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/bg/Ellipsebottom.png',
                width: size.width * 0.5,
              ),
            ),
            Positioned(
              top: 0,
              right: 50,
              child: Image.asset(
                'assets/bg/EllipseTR.png',
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 200,
              right: 125,
              child: Image.asset(
                'assets/bg/EllipseMed.png',
                width: size.width * 0.4,
              ),
            ),
            Positioned(
              top: 300,
              left: 15,
              child: Image.asset(
                'assets/bg/logo.png',
                width: size.width * 0.95,
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 191, 0),
                ),
                child: const Text(
                  'Get start',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

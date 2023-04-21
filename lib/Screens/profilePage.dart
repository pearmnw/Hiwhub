import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/welcomePage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    width: size.width * 0.4,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  // top: 525,
                  child: Image.asset(
                    'assets/bg/Ellipsebottom.png',
                    width: size.width * 0.5,
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 130,
                  child: Image.asset(
                    'assets/bg/EllipseTR.png',
                    width: size.width * 0.3,
                  ),
                ),
                Positioned(
                  top: 200,
                  right: 72,
                  child: Image.asset(
                    'assets/bg/EllipseMed.png',
                    width: size.width * 0.3,
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 70,
                  child: Image.asset(
                    'assets/bg/logo.png',
                    width: size.width * 0.65,
                  ),
                ),
                const Positioned(
                    child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                  radius: 100.0,
                )),
                Container(
                  child: Positioned(
                      bottom: 200,
                      left: 75,
                      child: Text(
                        auth.currentUser!.email!,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Positioned(
                  bottom: 135,
                  left: 140,
                  child: SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 191, 0),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}

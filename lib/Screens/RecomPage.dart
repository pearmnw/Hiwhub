import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/Screens/detailPage_for_Recom.dart';
import 'package:project/data/cloud_firestore.dart';
// import 'package:project/data/cloud_firestore.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  final auth = FirebaseAuth.instance;
  Position? _currentUserPosition;
  double? distanceInMeter = 0.0;
  List<Map<String, dynamic>> resList = [];

  Future _getTheDistance() async {
    final permissionStatus = await Permission.locationWhenInUse.request();
    if (permissionStatus != PermissionStatus.granted) {
      // Handle the case if permission is not granted
      return;
    }
    // itemList = await firebaseQuery.getItems();

    _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(_currentUserPosition!.altitude);
    // print(_currentUserPosition!.longitude);

    // double storelat = 5.0;
    // double storelng = -122.084;

    //
    // print(itemList);
  }

  Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    _getTheDistance().then((_) => _fetchData());
    super.initState();
  }

  Future<void> _fetchData() async {
    FirebaseQuery firebaseQuery = FirebaseQuery();
    List<Map<String, dynamic>> itemList = await firebaseQuery.getItems();
    setState(() {
      resList = itemList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (resList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/bg/EllipseTop.png',
              width: width * 0.4,
            ),
          ),
          Positioned(
            bottom: -95,
            left: -40,
            child: Image.asset(
              'assets/bg/Ellipsebottom.png',
              width: width * 0.5,
            ),
          ),
          Positioned(
            top: 40,
            left: 100,
            child: Text(
              "Hi, ${auth.currentUser!.email!}",
              textAlign: TextAlign.left,
              textScaleFactor: 1.5,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Positioned(
            top: 70,
            left: 50,
            child: Text(
              "What do you want to eat :)",
              textAlign: TextAlign.left,
              textScaleFactor: 1.5,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 204, 0),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Positioned(
            top: 110,
            left: 30,
            child: Text(
              "This is your recommend restaurant",
              textAlign: TextAlign.left,
              textScaleFactor: 1.5,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 145, 20, 0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  // crossAxisSpacing: 20,
                ),
                //itemCount: resList.length,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPageForRecom(
                                    data: resList[index],
                                  )),
                        );
                      },
                      child: Container(
                        color: const Color(0xFFF9BC1F),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            height: height * 0.26,
                            width: width * 0.8,
                            child: Image.network(
                              resList[index]['IntroImage'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: width * 0.75,
                            height: 125,
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  resList[index]['Name'].length > 15
                                      ? resList[index]['Name']
                                              .substring(0, 15) +
                                          '...'
                                      : resList[index]['Name'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}

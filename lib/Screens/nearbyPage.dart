import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/Screens/detailPage.dart';
import 'package:project/data/cloud_firestore.dart';

import 'homePage.dart';

class NearbyPage extends StatefulWidget {
  const NearbyPage({Key? key}) : super(key: key);

  @override
  State<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
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

    for (var i = 0; i < itemList.length; i++) {
      double storelat = itemList[i]['Latitude'];
      double storelng = itemList[i]['Longitude'];
      distanceInMeter = await Geolocator.distanceBetween(
        _currentUserPosition!.latitude,
        _currentUserPosition!.longitude,
        storelat,
        storelng,
      );
      var distance = distanceInMeter?.round().toInt();
      itemList[i]['distance'] = (distance! / 1000);
      //print("distance in between $distanceInMeter");
    }
    itemList.sort((a, b) => a['distance'].compareTo(b['distance']));
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
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text('homepage'),
      //   backgroundColor: const Color(0xFFF4E9CE),
      // ),
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
          const Positioned(
            top: 40,
            left: 109,
            child: Text(
              "Hi, Hermione Granger",
              textAlign: TextAlign.left,
              textScaleFactor: 1.5,
              style: TextStyle(
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
            left: 50,
            child: Text(
              "This is your nearby restaurant",
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
                              builder: (context) => DetailPage(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.location_on),
                                    Text(
                                      "${resList[index]['distance'].toStringAsFixed(2)} KM Away",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ],
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

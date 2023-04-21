import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/data/cloud_firestore.dart';

import 'homePage.dart';
import 'detailPage.dart';

class NearByPageIce extends StatefulWidget {
  const NearByPageIce({Key? key}) : super(key: key);

  @override
  _NearByPageIceState createState() => _NearByPageIceState();
}

class _NearByPageIceState extends State<NearByPageIce> {
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
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
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: height * 0.9,
                    width: width * 0.3,
                    child: Column(children: [
                      Container(
                        height: height * 0.12,
                        width: width,
                        child: Image.network(
                          resList[index]['IntroImage'],
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        resList[index]['Name'].length > 15
                            ? resList[index]['Name'].substring(0, 15) + '...'
                            : resList[index]['Name'],
                        style: const TextStyle(
                            fontSize: 18,
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
                    ]),
                  ));
            }),
      ),
    );
  }
}

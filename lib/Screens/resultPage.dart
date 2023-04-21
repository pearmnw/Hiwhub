import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/data/cloud_firestore.dart';

import 'detailPage.dart';

class ResultPage extends StatefulWidget {
  final String query;

  const ResultPage({Key? key, required this.query}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Position? _currentUserPosition;
  double? distanceInMeter = 0.0;
  List<Map<String, dynamic>> resList = [];
  bool flag = false;

  Future _getTheDistance() async {
    final permissionStatus = await Permission.locationWhenInUse.request();
    if (permissionStatus != PermissionStatus.granted) {
      return;
    }

    _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _fetchData(String queryString) async {
    FirebaseQuery firebaseQuery = FirebaseQuery();
    List<Map<String, dynamic>> itemList =
        await firebaseQuery.getItemsQuery(queryString);
    print(itemList);
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

      // print("distance in between $distanceInMeter");
    }
    // itemList.sort((a, b) => a['distance'].compareTo(b['distance']));
    if (itemList.isEmpty) {
      flag = true;
    }
    setState(() {
      resList = itemList;
    });
  }

  @override
  void initState() {
    print("============== get data ${widget.query} =============");
    _getTheDistance().then((_) => _fetchData(widget.query));
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.query),
  //     ),
  //     body: Container(
  //       child: Center(
  //         child: Text('Results for ${widget.query}'),
  //       ),
  //     ),
  //   );
  // }

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

    if (flag && resList.isEmpty) {
      return Center(
        child: Text('No results found.'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        // title: Text('homepage'),
        backgroundColor: const Color(0xFFF4E9CE),
      ),
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
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        resList[index]['Name'].length > 15
                            ? resList[index]['Name'].substring(0, 15) + '...'
                            : resList[index]['Name'],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on),
                          Text(
                            "${resList[index]['distance'].toStringAsFixed(2)} KM Away",
                            style: TextStyle(
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

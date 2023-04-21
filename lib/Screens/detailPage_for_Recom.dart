import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DetailPageForRecom extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailPageForRecom({Key? key, required this.data}) : super(key: key);

  @override
  _DetailPageForRecomState createState() => _DetailPageForRecomState();
}

class _DetailPageForRecomState extends State<DetailPageForRecom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Detail Page'),
            backgroundColor: const Color(0xFFF9BC1F),
          ),
          body: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.data['IntroImage']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['Name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Detail: ' + widget.data['Detail'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "District: ${widget.data['District']}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF9BC1F),
                  ),
                  onPressed: () {
                    MapsLauncher.launchCoordinates(
                        widget.data['Latitude'], widget.data['Longitude']);
                  },
                  child: const Text(
                    'Open the Google Map',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

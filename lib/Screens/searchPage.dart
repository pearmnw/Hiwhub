import 'package:flutter/material.dart';
import 'package:project/Screens/resultPage.dart';
// import 'package:project/Screens/resultPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _queryText = '';
  final TextEditingController _searchController = TextEditingController();

  void _onSubmitted(String value) {
    setState(() {
      _queryText = _searchController.text.trim(); // <-- modify this line
    });
    print("===================== Sended data ${value} =====================");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(query: _queryText),
      ),
    );
  }

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
                top: 290,
                left: 58,
                child: Column(children: [
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        hoverColor: const Color(0xFFF9BC1F),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ])),
            Positioned(
              top: 360,
              left: 162,
              child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    _onSubmitted(_queryText);
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9BC1F),
                    );
                  },
                  child: Text('Search'),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/bg/EllipseTop.png',
                width: size.width * 0.4,
              ),
            ),
            Positioned(
              top: 165,
              right: 72,
              child: Image.asset(
                'assets/bg/EllipseMed.png',
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              left: 0,
              top: 500,
              child: Image.asset(
                'assets/bg/Ellipsebottom.png',
                width: size.width * 0.5,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 90,
              top: 500,
              child: Image.asset(
                'assets/bg/EllipseTR.png',
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
            // Positioned(
            //     top: 140,
            //     left: 58,
            //     child: Column(
            //       children: [
            //         Container(
            //           color: Colors.white,
            //           child: Padding(
            //             padding: const EdgeInsets.all(20),
            //             child: Row(
            //               children: [
            //                 IconButton(
            //                     onPressed: () => _onSubmitted(_queryText),
            //                     icon: const Icon(
            //                       Icons.arrow_back_ios,
            //                       color: Color.fromARGB(255, 255, 204, 0),
            //                     ))
            //               ],
            //             ),
            //           ),
            //         )
            //       ],
            //     )),
          ],
        ),
      ),
    );
  }
}

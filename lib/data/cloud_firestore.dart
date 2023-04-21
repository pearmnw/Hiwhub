import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseQuery {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future getAllData() async {
  //   FirebaseQuery firebaseQuery = FirebaseQuery();
  //   List<Map<String, dynamic>> itemList = await firebaseQuery.getItems();
  //   return itemList;
  // }

  Future<List<Map<String, dynamic>>> getItems() async {
    List<Map<String, dynamic>> itemList = [];

    try {
      final collection = FirebaseFirestore.instance.collection('Restaurants');
      final querySnapshot = await collection.get();

      // for (var doc in querySnapshot.docs) {
      //   Map<String, dynamic> item = doc.data();
      //   item['id'] = doc.id;
      //   itemList.add(item);
      // }

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> item =
            Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
        itemList.add(item);
      });

      return itemList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getItemsQuery(String queryString) async {
    List<Map<String, dynamic>> itemList = [];

    try {
      final collection = FirebaseFirestore.instance.collection('Restaurants');
      final querySnapshot = await collection
          .where('Name', isGreaterThanOrEqualTo: queryString)
          // .where('Detail', isGreaterThanOrEqualTo: queryString)
          // .where('Detail', isGreaterThanOrEqualTo: queryString)
          .orderBy('Name')
          .limit(20)
          .get();

      // for (var doc in querySnapshot.docs) {
      //   Map<String, dynamic> item = doc.data();
      //   item['id'] = doc.id;
      //   itemList.add(item);
      // }

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> item =
            Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
        itemList.add(item);
      });

      return itemList;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

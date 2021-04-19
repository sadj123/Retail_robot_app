import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> scanBarcodeNormal() async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);
    print(barcodeScanRes);
  } on PlatformException {
    barcodeScanRes = 'Failed to get platform version.';
  }
}

class OrderScreen extends StatefulWidget {
  @override
  Order_state createState() => Order_state();
}

List<int> indices = [0, 5, 1, 2, 4, 3];

class Order_state extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    var indmap = indices.asMap();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(children: <Widget>[
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: <Widget>[
                      Text('Want to see',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold)),
                      Text("Your order?",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF004D40),
                              fontWeight: FontWeight.bold))
                    ]),
                    Image.asset(
                      'assets/imgs/order2.png',
                      height: 120,
                      width: 120,
                    )
                  ]),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TOTAL: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          indmap
                              .map((key, value) => MapEntry(
                                  key, docs[indices[key]].data()["price"]))
                              .values
                              .toList()
                              .fold(0, (p, c) => p + c)
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ],
                    ),
                  );
                }),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  return Expanded(
                    child: SizedBox(
                      height: 700,
                      child: ListView(
                          children: indmap
                              .map((key, value) => MapEntry(
                                    key,
                                    Dismissible(
                                        key: UniqueKey(),
                                        background: Container(
                                          alignment: Alignment.center,
                                          color: Colors.red,
                                          child: Icon(Icons.delete),
                                        ),
                                        onDismissed: (direction) {
                                          setState(() {
                                            print("eliminando" +
                                                value.toString());
                                            print(indices);
                                            indices.removeAt(key);
                                          });
                                        },
                                        child: casilla(context, docs, value)),
                                  ))
                              .values
                              .toList()),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}

Widget casilla(BuildContext context, docs, ind) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(children: <Widget>[
        ClipRRect(
          child: Image.asset(
            docs[ind].data()['url'],
            width: 100,
            fit: BoxFit.contain,
            height: 150,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        Container(
            padding: EdgeInsets.only(left: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    docs[ind].data()["name"],
                    style: TextStyle(
                        fontFamily: "Font2",
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            docs[ind].data()['net_wt'].toString() + 'gr',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(docs[ind].data()['price'].toString() + "\$",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ]),
    ),
  );
}
/*Center(
child: const Text('Press the button below to modify the order!')
),
floatingActionButton: FloatingActionButton(
onPressed: ()  => scanBarcodeNormal(),
child: Icon(Icons.add),
backgroundColor: Theme.of(context).primaryColor,
),*/

/*class DataController extends GetxController {
  Future getData(String colecction) async{
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(colecction).get();
    return snapshot.docs;
  }
  Future queryData(String queryString) async{
    return FirebaseFirestore.instance.collection('featured').where(
      'name', isGreaterThanOrEqualTo: queryString
    ).get();
  }
}*/

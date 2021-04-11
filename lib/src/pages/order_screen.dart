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



class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      body: Container(
      child: StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          List<DocumentSnapshot> docs = snapshot.data.docs;
          return Container(
          child:
            ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index){
                Map<String, dynamic> data = docs[index].data();
                return ListTile(
                  leading: Checkbox(value: data['ok']),
                  title: Text(data['name']),
                );
              }));
      }
      )
    ));
  }
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
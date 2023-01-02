
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tamplates_app/ui/styles/styles.dart';

class SelectedInventoryScreen extends StatefulWidget {
  @override
  State<SelectedInventoryScreen> createState() =>
      _SelectedInventoryScreenState();
}

class _SelectedInventoryScreenState extends State<SelectedInventoryScreen> {
  int num = 0;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "$num Items",
          style: TextStyle(fontSize: 20.w, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
              _firestore
                  .collection("my-inventory")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("my-data")
                  .where('value', isEqualTo: true)
                  .get()
                  .then((snapshot) {
                for (var doc in snapshot.docs) {
                  doc.reference.update({"value": false});
                }
              });
            },
            icon: Icon(
              num == 0 ? Icons.arrow_back : Icons.close,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text("Are you sure?"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'NO',
                                style: AppStyles.myTextStyle,
                              )),
                          TextButton(
                              onPressed: () {
                                _firestore
                                    .collection("my-inventory")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection("my-data")
                                    .where('value', isEqualTo: true)
                                    .get()
                                    .then((snapshot) {
                                  for (var doc in snapshot.docs) {
                                    doc.reference.delete();
                                  }
                                });

                                Fluttertoast.showToast(
                                    msg: "Delete Successfully");
                                setState(() {
                                  num = 0;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                'DELETE',
                                style: AppStyles.myTextStyle,
                              )),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete, size: 25, color: Colors.black))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Product Name",
                  style: AppStyles.titleStyle,
                ),
                const Icon(Icons.arrow_downward)
              ],
            ),
          ),
          StreamBuilder(
              stream: _firestore
                  .collection("my-inventory")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("my-data")
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      itemCount: data!.docs.length,
                      itemBuilder: (context, index) {
                        var indexData = data.docs[index];
                        return ListTile(
                          leading: Checkbox(
                              value: indexData['value'],
                              onChanged: (bool? val) {
                                setState(() {
                                  _firestore
                                      .collection("my-inventory")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("my-data")
                                      .doc(
                                          '${indexData['productName']} ${indexData['term']}')
                                      .update({"value": val}).whenComplete(() {
                                    _firestore
                                        .collection("my-inventory")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection("my-data")
                                        .where('value', isEqualTo: true)
                                        .get()
                                        .then((snapshot) {
                                      setState(() {
                                        num = snapshot.docs.length;
                                      });
                                    });
                                  });
                                });
                              }),
                          title: Text(
                              '${indexData['productName']} ${indexData['term']}'),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }
}

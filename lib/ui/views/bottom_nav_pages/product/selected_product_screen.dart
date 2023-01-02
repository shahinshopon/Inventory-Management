import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../styles/styles.dart';

class SelectedAllProductscreen extends StatefulWidget {
  @override
  State<SelectedAllProductscreen> createState() =>
      _SelectedAllProductscreenState();
}

class _SelectedAllProductscreenState extends State<SelectedAllProductscreen> {
  int num = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  progressDialog(context) => showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Text("Processing"),
              ],
            ),
          ),
        ),
      );

  // deletedProduct() {
  //   FirebaseFirestore.instance
  //       .collection("my-inventory")
  //       .get()
  //       .then((snapshot) {
  //     for (var element in snapshot.docs) {
  //       var user = element['email'];
  //       FirebaseFirestore.instance
  //           .collection("my-inventory")
  //           .doc(user)
  //           .collection("my-data")
  //           .where('value', isEqualTo: true)
  //           .get()
  //           .then((snapshot) {
  //         // for (var doc in snapshot.docs) {
  //         if (snapshot.docs.isNotEmpty) {
  //           Get.snackbar("", "Using another Inventory");
  //         } else {
  //           FirebaseFirestore.instance
  //               .collection("all-data")
  //               .doc(FirebaseAuth.instance.currentUser!.email)
  //               .collection("my-data")
  //               .where('value', isEqualTo: true)
  //               .get()
  //               .then((snapshot) {
  //             for (var doc in snapshot.docs) {
  //               doc.reference.delete();
  //             }
  //           });
  //           Fluttertoast.showToast(msg: "Delete Successfully");
  //         }
  //         //}
  //       });
  //     }
  //   });
  //   // Fluttertoast.showToast(
  //   //     msg: "Delete Successfully");
  //   setState(() {
  //     num = 0;
  //   });
  //   Navigator.pop(context);
  // }

  deleteProduct() {
    _firestore
        .collection("all-data")
        // .doc(FirebaseAuth.instance.currentUser!.email)
        // .collection("my-data")
        .where('value', isEqualTo: true)
        .where('num', isEqualTo: 1)
        .get()
        .then((snapshot) {
      var dd = snapshot.docs;
      if (dd.isNotEmpty) {
         _firestore
        .collection("all-data")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("my-data")
        .where('value', isEqualTo: true)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
     //all-data
    _firestore
        .collection("all-data")
        .where('value', isEqualTo: true)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
   
      } else {
        Fluttertoast.showToast(msg: "This Product is being used in inventory");
      }
    });

    //////////
    // _firestore
    //     .collection("all-data")
    //     .doc(FirebaseAuth.instance.currentUser!.email)
    //     .collection("my-data")
    //     .where('value', isEqualTo: true)
    //     .get()
    //     .then((snapshot) {
    //   for (var doc in snapshot.docs) {
    //     doc.reference.delete();
    //   }
    // });
    // //all-data
    // _firestore
    //     .collection("all-data")
    //     .where('value', isEqualTo: true)
    //     .get()
    //     .then((snapshot) {
    //   for (var doc in snapshot.docs) {
    //     doc.reference.delete();
    //   }
    // });

    // //all-user
    // _firestore.collection("my-inventory").get().then((snapshot) {
    //   for (var element in snapshot.docs) {
    //     var user = element['email'];

    //     for (var i = 0; i < user.length; i++) {
    //       _firestore
    //           .collection("my-inventory")
    //           .doc(user)
    //           .collection("my-data")
    //           .where('value', isEqualTo: true)
    //           .get()
    //           .then((snapshot) {
    //         for (var doc in snapshot.docs) {
    //           doc.reference.delete();
    //         }
    //       });
    //     }
    //   }
    // }
    // );

   // Fluttertoast.showToast(msg: "Delete Successfully");
    setState(() {
      num = 0;
    });
    Navigator.pop(context);
  }

  cancelSelectedproduct() {
    _firestore
        .collection("all-data")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("my-data")
        .where('value', isEqualTo: true)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({"value": false});
      }
    });
    _firestore
        .collection("all-data")
        .where('value', isEqualTo: true)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({"value": false});
      }
    });
    _firestore.collection("my-inventory").get().then((snapshot) {
      for (var element in snapshot.docs) {
        var user = element['email'];

        for (var i = 0; i < user.length; i++) {
          _firestore
              .collection("my-inventory")
              .doc(user)
              .collection("my-data")
              .where('value', isEqualTo: true)
              .get()
              .then((snapshot) {
            for (var doc in snapshot.docs) {
              doc.reference.update({"value": false});
            }
          });
        }
      }
    });
    setState(() {
      num = 0;
    });
    Navigator.pop(context);
  }

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
                  .collection("all-data")
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
                Future.delayed(const Duration(seconds: 4), () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text("Are you sure?"),
                          actions: [
                            TextButton(
                                onPressed: cancelSelectedproduct,
                                child: Text(
                                  'NO',
                                  style: AppStyles.myTextStyle,
                                )),
                            TextButton(
                                onPressed: deleteProduct,
                                child: Text(
                                  'DELETE',
                                  style: AppStyles.myTextStyle,
                                )),
                          ],
                        );
                      });
                });
                progressDialog(context);
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
                  .collection("all-data")
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
                                      .collection("all-data")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("my-data")
                                      .doc(indexData['productName'])
                                      .update({"value": val}).whenComplete(() {
                                    _firestore
                                        .collection("all-data")
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
                                  _firestore
                                      .collection("all-data")
                                      .doc(indexData['productName'])
                                      .update({"value": val});
                                  /////all user
                                  _firestore
                                      .collection("my-inventory")
                                      .get()
                                      .then((snapshot) {
                                    for (var element in snapshot.docs) {
                                      var user = element['email'];
                                      for (var i = 0; i < user.length; i++) {
                                        _firestore
                                            .collection("my-inventory")
                                            .doc(user)
                                            .collection("my-data")
                                            .where("productName",
                                                isEqualTo:
                                                    indexData['productName']
                                                        .toString())
                                            .get()
                                            .then((snapshot) {
                                          snapshot.docs.forEach((element) {
                                            element.reference
                                                .update({"value": val});
                                          });
                                        });
                                      }
                                    }
                                  });
                                });
                              }),
                          title: Text(indexData['productName']),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }
}

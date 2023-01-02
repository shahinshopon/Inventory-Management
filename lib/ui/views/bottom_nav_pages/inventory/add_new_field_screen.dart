import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamplates_app/ui/styles/styles.dart';
import 'package:tamplates_app/ui/widgets/custom_appbar.dart';

class AddTermScreen extends StatelessWidget {
  TextEditingController _addTermController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Term',
        onPress: () {
            Get.back();
          },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: AppStyles.borderDecoration,
              child: TextFormField(
                controller: _addTermController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Close', style: AppStyles.titleStyle)),
                TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('term')
                          .doc(_addTermController.text)
                          .set({
                        "term": _addTermController.text.capitalizeFirst
                      }).then((value) {
                        Get.back();
                        _addTermController.clear();
                      });
                    },
                    child: Text(
                      'Save',
                      style: AppStyles.titleStyle,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddContainerScreen extends StatelessWidget {
  TextEditingController _addContainerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Container',
        onPress: () {
            Get.back();
          },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: AppStyles.borderDecoration,
              child: TextFormField(
                controller: _addContainerController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Close', style: AppStyles.titleStyle)),
                TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('container')
                          .doc(_addContainerController.text)
                          .set({
                        "container":
                            _addContainerController.text.capitalizeFirst
                      }).then((value) {
                        Get.back();
                        _addContainerController.clear();
                      });
                    },
                    child: Text(
                      'Save',
                      style: AppStyles.titleStyle,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddMeasureScreen extends StatelessWidget {
  TextEditingController _addMeasureController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Measure',
        onPress: () {
            Get.back();
          },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: AppStyles.borderDecoration,
              child: TextFormField(
                controller: _addMeasureController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Close', style: AppStyles.titleStyle)),
                TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('measure')
                          .doc(_addMeasureController.text)
                          .set({
                        "measure": _addMeasureController.text.capitalizeFirst
                      }).then((value) {
                        Get.back();
                        _addMeasureController.clear();
                      });
                    },
                    child: Text(
                      'Save',
                      style: AppStyles.titleStyle,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddRoomScreen extends StatelessWidget {
  TextEditingController _addRoomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Room',
        onPress: () {
            Get.back();
          },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: AppStyles.borderDecoration,
              child: TextFormField(
                controller: _addRoomController,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Close', style: AppStyles.titleStyle)),
                TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('room')
                          .doc(_addRoomController.text)
                          .set({
                        "room": _addRoomController.text.capitalizeFirst
                      }).then((value) {
                        Get.back();
                        _addRoomController.clear();
                      });
                    },
                    child: Text(
                      'Save',
                      style: AppStyles.titleStyle,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

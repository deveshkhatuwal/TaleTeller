import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/home_controller.dart';
import 'package:storyadminpanel/model/category_model.dart';
import 'package:storyadminpanel/model/story_model.dart';
import '../../ui/common/common.dart';
import '../../util/pref_data.dart';
import 'key_table.dart';

class FirebaseData {
  static changePassword(
      {required String password,
      required Function function,
      required BuildContext context}) async {
    String id = await PrefData.getLoginId();

    User? user = await FirebaseAuth.instance.currentUser;
    print("cred==true==$user");

    if (user != null) {
      print("cred==true");

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(KeyTable.adminData)
          .doc(id)
          .get();

      Map data = documentSnapshot.data() as Map;

      String p = data['password'];

      print("cred==$password");


      final cred = await EmailAuthProvider.credential(
          email: user.email!, password: p);


      print("cred==$cred");
      await user.reauthenticateWithCredential(cred).then((value) async {
        await user.updatePassword(password).then((_) {

          FirebaseFirestore.instance
              .collection(KeyTable.adminData)
              .doc(id)
              .update({'password': password}).then((value) {
            showCustomToast(
                context: context, message: "Password change successfully");
            function();
          });


        }).catchError((error) {




          print(error);
        });
      }).catchError((err) {
        print(err);
      });

      print("id----${id}");


    }
  }

  static insertData(
      {required var map,
      required String tableName,
      required Function function,
      required BuildContext context}) async {
    FirebaseFirestore.instance.collection(tableName).add(map).then((value) {
      showCustomToast(
          message: "Add Successfully...", title: '', context: context);
      function();
    });
  }

  static setData(
      {required var map,
      required String tableName,
      required String doc,
      required Function function,
      bool? isToast,
      required BuildContext context}) {
    FirebaseFirestore.instance
        .collection(tableName)
        .doc(doc)
        .set(map)
        .then((value) {
      if (isToast == null) {
        showCustomToast(
            message: "Update Successfully...",
            title: 'Success',
            context: context);
      }
      function();
    });
  }

  static updateData(
      {required var map,
      required String tableName,
      required String doc,
      required Function function,
      bool? isToast,
      required BuildContext context}) {
    FirebaseFirestore.instance
        .collection(tableName)
        .doc(doc)
        .update(map)
        .then((value) {
      if (isToast == null) {
        showCustomToast(
          message: "Update Successfully...",
          title: 'Success',
          context: context,
        );
      }
      function();
    });
  }

  static deleteRecentStory(
      {required BuildContext context,
      required Function function,
      required String storyId}) async {
    deleteSliderStory(
        context: context,
        function: (doc) {
          FirebaseData.deleteData(
              tableName: KeyTable.sliderList, doc: doc, function: () {});
        },
        storyId: storyId);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.recentList)
        .where(KeyTable.storyId, isEqualTo: storyId)
        .get();

    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      function(querySnapshot.docs[0].id);
    }
  }

  static deleteSliderStory(
      {required BuildContext context,
      required Function function,
      required String storyId}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.sliderList)
        .where("KeyTable.storyId", isEqualTo: storyId)
        .get();

    if (querySnapshot.size > 0 && querySnapshot.docs.isNotEmpty) {
      function(querySnapshot.docs[0].id);
    }
  }

  static deleteData(
      {required String tableName,
      required String doc,
      required Function function}) {
    FirebaseFirestore.instance
        .collection(tableName)
        .doc(doc)
        .delete()
        .then((value) {
      function();
    });
  }

  static deleteBatch(Function function, String id, String tableName, String key,
      {bool slider = false}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(tableName)
        .where(key, isEqualTo: id)
        .get();

    print(
        "sfklhsdlghldkfg===$id==${querySnapshot.docs.isNotEmpty}===${querySnapshot.docs.length}===${tableName}");
    if (querySnapshot.docs.isNotEmpty) {
      await Future.wait(querySnapshot.docs.map((e) async {
        // print("e===${e.id}==${tableName}===${id}");
        //
        if (slider) {
          // FirebaseData.deleteBatch(() {
          //
          //
          //   FirebaseData.deleteData(
          //       tableName: KeyTable.recentList,
          //       doc: e.id,
          //       function: () {
          //         FirebaseData.refreshStoryData();
          //         FirebaseData.refreshSliderData();
          //       });
          // }, e.id, KeyTable.sliderList,
          //   KeyTable.storyId,
          // );

          await deleteBackendData(e.id, KeyTable.sliderList);
          await deleteBackendData(e.id, KeyTable.recentList);

          // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          //     .collection(KeyTable.sliderList)
          //     .where(KeyTable.storyId, isEqualTo: e.id)
          //     .get();
          //
          //
          // if (querySnapshot.docs.isNotEmpty && querySnapshot.docs[0].exists) {
          //   await FirebaseFirestore.instance
          //       .collection(KeyTable.sliderList).doc(querySnapshot.docs[0].id).delete();
          // }
          //
          //  querySnapshot = await FirebaseFirestore.instance
          //     .collection(KeyTable.recentList)
          //     .where(KeyTable.storyId, isEqualTo: e.id)
          //     .get();
          //
          //
          // if (querySnapshot.docs.isNotEmpty && querySnapshot.docs[0].exists) {
          //   await FirebaseFirestore.instance
          //       .collection(KeyTable.recentList).doc(querySnapshot.docs[0].id).delete();
          // }
        }

        await FirebaseFirestore.instance
            .collection(tableName)
            .doc(e.id)
            .delete();
      }));

      function();
    } else {
      function();
    }
  }

  static deleteBackendData(String id, String tableName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(tableName)
        .where(KeyTable.storyId, isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty && querySnapshot.docs[0].exists) {
      await FirebaseFirestore.instance
          .collection(tableName)
          .doc(querySnapshot.docs[0].id)
          .delete();
    }
  }

  static Future<bool> checkExist(String docID, String collection) async {
    bool exist = false;
    try {
      print("isExist====${exist}===$docID===$collection");
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .doc(docID)
          .get();

      exist = documentSnapshot.exists;

      print("isExist====${exist}");

      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }

  static Future<DocumentSnapshot?> checkStoryExist(
      String docID, String collection) async {
    bool exist = false;
    try {
      print("isExist====${exist}===$docID===$collection");
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collection)
          .doc(docID)
          .get();

      exist = documentSnapshot.exists;

      print("isExist====${exist}");

      return documentSnapshot;
    } catch (e) {
      // If any error
      return null;
    }
  }

  static Future<bool> checkIfDocExists(String docId, String collection) async {
    bool isExist = await checkExist(docId, collection);

    if (isExist) {
      await FirebaseFirestore.instance
          .doc("$collection/$docId")
          .get()
          .then((doc) async {
        isExist = await checkExist(
            StoryModel.fromFirestore(doc).refId!, KeyTable.categoryList);
      });

      return isExist;
    } else {
      return false;
    }
//
//
//
//     } catch (e) {
//       return false;
//     }
  }

  static Future<bool> checkIfDetailExists(
      String docId, String collection) async {
    bool isExist = await checkExist(docId, collection);

    if (isExist) {
      await FirebaseFirestore.instance
          .doc("$collection/$docId")
          .get()
          .then((doc) async {
        isExist = await checkExist(
            StoryModel.fromFirestore(doc).refId!, KeyTable.appDetail);
      });
      return isExist;
    } else {
      return false;
    }
  }

  static Future<bool> checkCategoryExists(String docId,
      {String? collection}) async {
    print("doc===$docId");
    try {
      var collectionRef = FirebaseFirestore.instance
          .collection(collection == null ? KeyTable.categoryList : collection);

      var doc = await collectionRef.doc(docId).get();

      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getCategoryRefId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.categoryList)
        .orderBy(KeyTable.refId, descending: true)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.length > 0) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.length > 0) {
          CategoryModel categoryModel = CategoryModel.fromFirestore(list1[0]);
          return (categoryModel.refId! + 1);
        }
      }
      return 1;
    } else {
      return 1;
    }
  }

  static Future<int> getCategoryLength() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.categoryList)
        .orderBy(KeyTable.refId, descending: true)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.length > 0) {
        return querySnapshot.docs.length;
      }
      return 0;
    } else {
      return 0;
    }
  }

  static Future<int> getLastIndexFromTable(String table) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(table)
        .orderBy(KeyTable.index, descending: true)
        .get();

    if (querySnapshot.size > 0) {
      if (querySnapshot.docs.length > 0) {
        List<DocumentSnapshot> list1 = querySnapshot.docs;
        if (list1.length > 0) {
          StoryModel categoryModel = StoryModel.fromFirestore(list1[0]);
          return (categoryModel.index! + 1);
        }
      }
      return 1;
    } else {
      return 1;
    }
  }

  static refreshStoryData() {
    HomeController homeController = Get.find();
    homeController.fetchStoryData();
  }

  static refreshCategoryData() {
    HomeController homeController = Get.find();
    homeController.fetchCategoryData();
  }

  static refreshSliderData() {
    HomeController homeController = Get.find();
    homeController.fetchSliderData();
  }

  static getStory(String storyId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(KeyTable.storyList)
        .doc(storyId)
        .get();
    StoryModel storyModel = StoryModel.fromFirestore(snapshot);

    print("story-----${storyModel.name}");

    return storyModel;
  }
}

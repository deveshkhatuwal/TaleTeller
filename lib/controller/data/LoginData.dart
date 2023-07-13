import 'package:client_information/client_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/ui/common/common.dart';
import 'package:storyadminpanel/util/constants.dart';

import '../../main.dart';
import '../../model/admin_model.dart';
import '../../util/app_routes.dart';
import '../../util/pref_data.dart';
import 'FirebaseData.dart';
import 'key_table.dart';

class LoginData {
  static Future<bool> login({username, password, context}) async {
    print("username===$username === $password");

    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut();
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(KeyTable.adminData)
        .where(KeyTable.keyUserName, isEqualTo: username)
        .where(KeyTable.keyPassword, isEqualTo: password)
        .get();

    print("username===${querySnapshot.docs.isNotEmpty}");

    if (querySnapshot.docs.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: username, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }

      querySnapshot.docs.forEach((element) async {
        AdminModel adminModel = AdminModel.fromFirestore(element);

        adminModel.deviceId = deviceID.value;

        if (FirebaseAuth.instance.currentUser != null) {

          FirebaseData.updateData(
              map: adminModel.toJson(),
              tableName: KeyTable.adminData,
              doc: adminModel.id ?? "",
              function: () {},
              context: context,
              isToast: false);
        }

        print("i===${FirebaseAuth.instance.currentUser}");

        PrefData.setLogin(
            true, element.id, FirebaseAuth.instance.currentUser != null);
        // PrefData.setLogin(true,element.id,adminModel.isAdmin);
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<bool?> createAdmin({username, password, context}) async {
    print("username===$username === $password");

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);

      if (userCredential.user != null) {
        await FirebaseFirestore.instance.collection(KeyTable.adminData).add({
          KeyTable.keyPassword: password,
          KeyTable.keyUserName: username,
        });

        return await login(
            password: password, context: context, username: username);
      }

      showCustomToast(context: context, message: 'Config Data');

      return null;
    } on FirebaseAuthException catch (e) {
      print("3===${e.code}");
      if (e.code == 'invalid-email') {
        print('Invalid email');

        showCustomToast(context: context, message: 'Invalid email');
      }
      if (e.code == 'weak-password') {
        showCustomToast(
            context: context, message: 'The password provided is too weak.');

        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showCustomToast(
            context: context,
            message: 'The account already exists for that email.');

        // print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e);
    }

    return false;
  }

  static getDeviceId() async {
    String id = await PrefData.getLoginId();

    print("id----11-----${id}");

    if (id.isEmpty) {
      LoginData.sendLoginPage();
    }

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(KeyTable.adminData)
        .doc(id)
        .get();

    bool isData = true;
    if (snapshot.exists && FirebaseAuth.instance.currentUser !=null) {
      AdminModel adminModel = AdminModel.fromFirestore(snapshot);

      deviceID.value = await getDeviceIdentifier();

      isData = (adminModel.deviceId! == deviceID.value) ? true : false;

      print(
          "device----11-----${adminModel.deviceId}---${adminModel.username}-----${deviceID.value}===${FirebaseAuth.instance.currentUser}");

      print("isData---${isData}");

      if (!isData) {
        // await FirebaseFirestore.instance
        //     .collection(KeyTable.adminData)
        //     .doc(id)
        //     .update({"isAccess": false});

        LoginData.sendLoginPage();
      }
    } else {
      isData = true;
    }
  }

  static sendLoginPage() {
    logout();
    Future.delayed(Duration(seconds: 1), () {
      Get.toNamed(KeyUtil.loginPage);
    });
  }

  static logout() async {
    String loginId = await PrefData.getLoginId();

    if (loginId.isNotEmpty) {
      // await FirebaseFirestore.instance
      //     .collection(KeyTable.adminData)
      //     .doc(loginId)
      //     .update({
      //   "isAccess": false
      //   // LoginData.keyActive: false,
      // });
    }

    PrefData.setLogin(false, loginId, false);
    PrefData.setAction(actionDashBoard);

    // if(isUpdate ==null) {
    //   update();
    // }
  }

  static Future<String> getDeviceIdentifier() async {
    ClientInformation info = await ClientInformation.fetch();
    print("info===${info.deviceId}");
    return info.deviceId;

    // String? deviceId = await PlatformDeviceId.deviceInfoPlugin.in;
    // print("devi-----${deviceId}");
    // return deviceId ?? "";
  }
}

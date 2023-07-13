


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/data/LoginData.dart';
import '../ui/common/common.dart';

class PrefData {
  static String pkgName = "story_admin_panel";
  static String login = pkgName + "login";
  static String loginId = pkgName + "loginId";
  static String keyIsAccess = pkgName + "access";
  static String keyAction = pkgName + "action";

  static setLogin(bool s,String id,bool isAccess) async {

    if(!s){
      await FirebaseAuth.instance.signOut();
    }



    print("id===$id");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(login, s);
    prefs.setString(loginId, id);
    prefs.setBool(keyIsAccess, isAccess);




  }


  static Future checkAccess({required BuildContext context,required Function function}) async {
    print("isAccess===true");


    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAccess= prefs.getBool(keyIsAccess) ?? false;

    print("isAccess===$isAccess");
    if(isAccess){
      await LoginData.getDeviceId();
      function();
    }else{
      showCustomToast(message: "You are demo user..",context: context);
    }
  }

  static getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(login) ?? false;
  }

  static getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(loginId) ?? "";
    return id;
  }



  static Future<int> getAction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyAction) ?? 0;
  }

  static setAction(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(keyAction, value);
  }


}

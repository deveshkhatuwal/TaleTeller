import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';




int actionDashBoard=0;
int actionCategories=1;
int dummyActionCategories=-1;
int actionStories=2;
int dummyActionStories=-2;
int actionHomeSlider=3;
int dummyActionHomeSlider=-3;
int actionSendNotification=4;
int actionSettings=5;
int actionAddCategory=6;
int actionEditCategory=7;
int actionEditStory=9;
int actionAddStory=8;
int actionAddSlider=10;


List<int> mainActionList=[actionCategories,actionStories,actionHomeSlider,actionSendNotification,actionSettings];
List<int> dummyActionList=[dummyActionCategories,dummyActionStories,dummyActionHomeSlider];
int dummyAction=-1;


// int dummyActionDashBoard=0;
// int dummyActionCategories=1;
// int dummyActionStories=2;
// int dummyActionHomeSlider=3;
// int dummyActionSendNotification=4;
// int dummyActionSettings=5;
// int dummyActionAddCategory=6;
// int dummyActionEditCategory=7;
// int dummyActionEditStory=9;
// int dummyActionAddStory=8;
// int dummyActionAddSlider=10;

class Constants{




  static String assetPath="assets/images/";
  static String assetSvgPath="assets/svg/";
  static String assetDarkSvgPath="assets/dark/";
  static String fontsFamily="PlusJakartaText";
  static String displayFontsFamily="PlusJakartaDisplay";
  static String headerFontsFamily="Latinotype";
  static String serverKey="key=AAAAehi1tLY:APA91bH0EoT8VgCDxQ__KiZiTLdtdeHysSPhL8UlvKngcfPEvnAfezTM73aG02iFSEAivCGWMg-fi0668c5WN_wpzzxjzzus0rEcjqDaBmTg8E1y0j-Q4uTlUzhWPYjhlnnJ0eRjGPeS";

  static void exitApp() {
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  static pushPage(var className, {Function? function}) {
    Get.toNamed(className)!.then((value) {
      if(function!=null){
        function();
      }
    });
  }

}
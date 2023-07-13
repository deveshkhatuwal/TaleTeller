import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/data/FirebaseData.dart';
import 'package:storyadminpanel/controller/home_controller.dart';
import 'package:storyadminpanel/main.dart';
import 'package:storyadminpanel/theme/color_scheme.dart';
import 'package:storyadminpanel/ui/common/common.dart';
import 'package:storyadminpanel/ui/dashboard/recent/subwidget/recent_mobile_widget.dart';
import 'package:storyadminpanel/ui/dashboard/recent/subwidget/recent_web_widget.dart';
import 'package:storyadminpanel/ui/home/home_page.dart';
import 'package:storyadminpanel/util/constants.dart';
import 'package:storyadminpanel/util/responsive.dart';

import '../../controller/data/LoginData.dart';
import '../../controller/data/key_table.dart';

class DashboardScreen extends StatefulWidget {
  final Function function;

  DashboardScreen({required this.function});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();

    LoginData.getDeviceId();

    Future.delayed(
      Duration.zero,
      () {
        // homeController.fetchCategoryData();
        // homeController.fetchStoryData();
        // homeController.fetchStoryData();

        print(
            "category------------${homeController.categoryList.length}----------${homeController.storyList.length}");
      },
    );
  }

  getCategoryLen() async {
    int len = await FirebaseData.getCategoryLength();

    String value = len.toString();

    print("len----${value}");

    return value;

    // print("len---${len.toString()}");
    //
    // return len.toString();
  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);


    return SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerticalSpace(context, 35),
            getTextWidget(context, 'DashBoard', 75, getFontColor(context),
                    fontWeight: FontWeight.w700)
                .marginSymmetric(horizontal: getDefaultHorSpace(context)),
            getVerticalSpace(context, 35),
            SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: getDefaultHorSpace(context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 35.h,
                          runSpacing: 35.h,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(KeyTable.categoryList)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return itemWidget(
                                      title: 'Categories',
                                      value:
                                          snapshot.data!.docs.length.toString(),
                                      context: context,
                                      bgColor: 'shape_1.png',
                                      icon: 'category_new.svg',
                                      function: () {
                                        changeAction(actionCategories);
                                      }
                                      // actionAddNew: () {
                                      //   changeAction(actionAddCategory);
                                      // },
                                      // actionViewAll: () {
                                      //   changeAction(actionCategories);
                                      // }
                                      );
                                } else {
                                  return itemWidget(
                                      title: 'Categories',
                                      value: 0.toString(),
                                      context: context,
                                      bgColor: 'shape_1.png',
                                      icon: 'category_new.svg',
                                      function: () {
                                        changeAction(actionCategories);
                                      }
                                      // actionAddNew: () {
                                      //   changeAction(actionAddCategory);
                                      // },
                                      // actionViewAll: () {
                                      //   changeAction(actionCategories);
                                      // }
                                      );
                                }
                              },
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(KeyTable.storyList)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return itemWidget(
                                      title: 'Stories',
                                      value:
                                          snapshot.data!.docs.length.toString(),
                                      context: context,
                                      bgColor: 'shape_2.png',
                                      icon: 'story_new.svg',
                                      function: () {
                                        changeAction(actionStories);
                                      }
                                      // actionAddNew: () {},
                                      // actionViewAll: () {}
                                      );
                                } else {
                                  return itemWidget(
                                      title: 'Stories',
                                      value: 0.toString(),
                                      context: context,
                                      bgColor: 'shape_2.png',
                                      icon: 'story_new.svg',
                                      function: () {
                                        changeAction(actionStories);
                                      }
                                      // actionAddNew: () {},
                                      // actionViewAll: () {}
                                      );
                                }
                              },
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(KeyTable.sliderList)
                                  .snapshots(),
                              builder: (context, snapshot) {

                                if(snapshot.data != null){
                                  List<DocumentSnapshot> list = snapshot.data!.docs;


                                    //
                                    // RxList<String> sliderList = <String>[].obs;
                                    //
                                    //
                                    // list.forEach((element) async {
                                    //
                                    //   SliderModel sliderModel = SliderModel.fromFirestore(element);
                                    //
                                    //   DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(KeyTable.storyList).doc(sliderModel.storyId).get();
                                    //
                                    //   if(snapshot.exists){
                                    //
                                    //     StoryModel storyModel = StoryModel.fromFirestore(snapshot);
                                    //
                                    //     DocumentSnapshot categorySnapshot = await FirebaseFirestore.instance.collection(KeyTable.categoryList).doc(storyModel.refId).get();
                                    //
                                    //     if(categorySnapshot.exists){
                                    //       sliderList.add(sliderModel.storyId!);
                                    //     }
                                    //
                                    //     print("slider-------------${sliderList}");
                                    //   }
                                    //
                                    //   sliderList.refresh();
                                    // });



                                    return Obx(() => itemWidget(
                                        title: 'Home Slider',
                                        value: (list.isNotEmpty)?list.length
                                            .toString():0.toString(),
                                        context: context,
                                        bgColor: 'shape_3.png',
                                        icon: 'slider_new.svg',
                                        function: () {
                                          changeAction(actionHomeSlider);
                                        }
                                      // actionAddNew: () {},
                                      // actionViewAll: () {}
                                    ));
                                    
                                }else{
                                  return itemWidget(
                                      title: 'Home Slider',
                                      value: 0
                                          .toString(),
                                      context: context,
                                      bgColor: 'shape_3.png',
                                      icon: 'slider_new.svg',
                                      function: () {
                                        changeAction(actionHomeSlider);
                                      }
                                    // actionAddNew: () {},
                                    // actionViewAll: () {}
                                  );
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            getVerticalSpace(context, 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(KeyTable.recentList).limit(10)
                    .orderBy(KeyTable.index, descending: true)
                    .snapshots(),
                builder: (context1, snapshot) {
                  print("state===${snapshot.connectionState}");

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return getProgressWidget(context);
                  }
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.active) {
                    List<DocumentSnapshot> list = snapshot.data!.docs;
                    print("list===${list.length}===");

                    return list.length > 0
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        getTextWidget(context, "Recently Added Stories", 50,
                            getFontColor(context),
                            fontWeight: FontWeight.w800)
                            .marginSymmetric(horizontal: getDefaultHorSpace(context)),
                        getVerticalSpace(context, 20),

                        Expanded(child: getCommonContainer(context: context,margin: EdgeInsets.symmetric(
                            horizontal: getDefaultHorSpace(context)),
                            horSpace: 20.h,

                            // child: Container()
                            child:  isWeb(context)
                                ? RecentWebScreen(
                              list: list,
                            )
                                : RecentMobileScreen(
                              list: list,
                            )

                        ))
                      ],
                    )
                        : Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            getVerticalSpace(context, 35),
          ],
        ),
      ),
    );
  }

  itemWidget({
    required context,
    required title,
    required value,
    required icon,
    required bgColor,
    required Function function,
    // required Function actionAddNew,
    // required Function actionViewAll
  }) {
    // ignore: unused_element
    Widget button(String title, Function function) {
      return InkWell(
        onTap: () {
          function();
        },
        child: Container(
          decoration: getDefaultDecoration(
            bgColor: getPrimaryColor(context),
            radius: getResizeRadius(context, 20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.h),
          alignment: Alignment.center,
          child: getTextWidget(context, title, 30, Colors.white,
              fontWeight: FontWeight.w400),
        ),
      );
    }

    Widget subWidget = ClipRRect(
      borderRadius: BorderRadius.circular((getResizeRadius(context, 35))),
      child: Column(
        children: [
          Container(
            // height: 50.h,
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
            child: Row(
              children: [
                imageSvg(icon,
                    height: 35.h,
                    width: 35.h,
                    folder: themeController.checkDarkTheme()
                        ? Constants.assetDarkSvgPath
                        : Constants.assetSvgPath),
                SizedBox(
                  width: 12.h,
                ),
                Expanded(
                    child: getTextWidget(
                        context, title, 48, getFontColor(context),
                        fontWeight: FontWeight.w500)),
                getTextWidget(context, value, 110, getFontColor(context),
                    fontWeight: FontWeight.bold)
              ],
            ),
            // decoration: getSideDecoration(
            //     bgColor: '#CDF5FB'.toColor(),
            //     radius: getResizeRadius(context, 30),
            //     topLeft: true,
            //     topRight: true,
            //
            // ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.h),
          //
          //   child: Row(
          //     children: [
          //
          //
          //
          //
          //
          //       Expanded(child: InkWell(
          //         onTap: (){
          //           actionViewAll();
          //         },
          //         child: getTextWidget(context,'View All', 45, getFontColor(context)
          //             ,fontWeight: FontWeight.w500),
          //       )),
          //
          //
          //       InkWell(
          //         onTap: (){
          //           actionAddNew();
          //         },
          //         child: Container(width: 35.h,height: 35.h,
          //           decoration: BoxDecoration(shape: BoxShape.circle,color: getPrimaryColor(context)),
          //           alignment: Alignment.center,
          //           child: Icon(Icons.add,color: Colors.white,size: 25.h,),),
          //       )
          //
          //     ],
          //   ),
          //
          //   // height: 50.h,
          //   // decoration: getSideDecoration(
          //   //     bgColor: '#CDF5FB'.toColor(),
          //   //     radius: getResizeRadius(context, 30),
          //   //     bottomLeft: true,
          //   //     bottomRight: true,
          //   //     isShadow: false
          //   // ),
          // ),
        ],
      ),
    );
    // Stack(
    //   children: [
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         getTextWidget(context, value, 80, getFontColor(context),
    //             fontWeight: FontWeight.w700),
    //         SizedBox(
    //           height: 12.h,
    //         ),
    //         getTextWidget(context, title, 55, getFontColor(context),
    //             fontWeight: FontWeight.w600),
    //         SizedBox(
    //           height: 18.h,
    //         ),
    //         Row(
    //           children: [
    //             button('Add New', () {
    //               actionAddNew();
    //             }),
    //             getHorizontalSpace(8),
    //             button('View All', () {
    //               actionViewAll();
    //             }),
    //           ],
    //         )
    //       ],
    //     ).paddingOnly(left: 15.h, top: 18.h, bottom: 18.h, right: 15.h),
    //     Align(
    //       alignment: Alignment.topRight,
    //       child: ClipRRect(
    //           borderRadius: BorderRadius.only(
    //               topRight: Radius.circular(getResizeRadius(context, 19))),
    //           child: Container(
    //             height: 100.h,
    //             width: 90.h,
    //             child: Stack(
    //               children: [
    //                 Image.asset(
    //                   Constants.assetPath + bgColor,
    //                   height: double.infinity,
    //                   width: double.infinity,
    //                   fit: BoxFit.cover,
    //                 ),
    //                 Center(
    //                   child: imageSvg(
    //                     icon,
    //                     height: 48.h,
    //                     width: 48.h,
    //                   ),
    //                 ).marginOnly(left: 10.h)
    //               ],
    //             ),
    //           )),
    //     )
    //   ],
    // );

    return InkWell(
      onTap: () {
        function();
      },
      child: Responsive.isDesktop(context)
          ? Container(
              width: 300.h,
              // decoration: getDefaultDecoration(
              //     bgColor: getCardColor(context),
              //     radius: getResizeRadius(context, 30),
              //     isShadow: true),
              decoration: BoxDecoration(
                  color: getSubCardColor(context),
                  borderRadius: BorderRadius.all(
                      Radius.circular(getResizeRadius(context, 35)))),
              child: subWidget)
          : Container(
              decoration: BoxDecoration(
                  color: getSubCardColor(context),
                  borderRadius: BorderRadius.all(
                      Radius.circular(getResizeRadius(context, 35)))),
              child: subWidget,
            ),
    );
  }
}
// Figma Flutter Generator Group1437Widget - GROUP

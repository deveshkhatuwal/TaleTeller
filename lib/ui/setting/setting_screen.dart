import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/data/key_table.dart';
import 'package:storyadminpanel/controller/setting_controller.dart';
import 'package:storyadminpanel/model/app_detail_model.dart';
import 'package:storyadminpanel/theme/app_theme.dart';
import 'package:storyadminpanel/util/pref_data.dart';

import '../../controller/data/LoginData.dart';
import '../../controller/home_controller.dart';
import '../../theme/color_scheme.dart';
import '../../util/responsive.dart';
import '../common/common.dart';
import '../story/addStory/add_story_screen.dart';

class SettingScreen extends StatefulWidget {
  final Function function;

  SettingScreen({required this.function});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();

    LoginData.getDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: getDefaultHorSpace(context), vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextWidget(context, 'Settings', 75, getFontColor(context),
                fontWeight: FontWeight.w700),
            getVerticalSpace(context, 35),
            Expanded(
                child: getCommonContainer(
              context: context,
              verSpace: 0,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(KeyTable.appDetail)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data != null && snapshot.data!.size > 0) {
                      List<DocumentSnapshot> list = snapshot.data!.docs;

                      AppDetailModel model =
                          AppDetailModel.fromFirestore(list[0]);

                      print("model-----${model}");

                      // bool isEdit = model != null;

                      return GetBuilder<SettingController>(
                        init: SettingController(appDetailModel: model),
                        builder: (controller) {
                          return ListView(
                            children: [
                              getVerticalSpace(
                                  context, (getCommonPadding(context) / 2)),
                              // itemSubTitle('App Name', context),
                              // getVerticalSpace(context, 10),
                              // getTextFiledWidget(context, "Enter app name..",
                              //     controller.appNameController),
                              // getVerticalSpace(context, 22),

                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          itemSubTitle(
                                              'App ad id (Android)', context),
                                          getVerticalSpace(context, 10),
                                          getTextFiledWidget(
                                              context,
                                              "Enter app ad id..",
                                              controller.appAdIdController),
                                        ],
                                      )),
                                  getHorizontalSpace(context, 20.h),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          itemSubTitle(
                                              'App ad id (ios)', context),
                                          getVerticalSpace(context, 10),
                                          getTextFiledWidget(
                                              context,
                                              "Enter app ad id..",
                                              controller.iosAppAdIdController),
                                        ],
                                      ))
                                ],
                              ),

                              // getVerticalSpace(context, 22),

                              getVerticalSpace(context, 22),

                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          itemSubTitle('Banner Ad Id (Android)',
                                              context),
                                          getVerticalSpace(context, 10),
                                          getTextFiledWidget(
                                              context,
                                              "Enter banner ad id..",
                                              controller
                                                  .andBannerAdIdController),
                                        ],
                                      )),
                                  getHorizontalSpace(context, 20.h),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          itemSubTitle(
                                              'Banner Ad Id (ios)', context),
                                          getVerticalSpace(context, 10),
                                          getTextFiledWidget(
                                              context,
                                              "Enter banner ad id..",
                                              controller
                                                  .iosBannerAdIdController),
                                        ],
                                      ))
                                ],
                              ),

                              // getVerticalSpace(context, 22),

                              getVerticalSpace(context, 22),

                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          itemSubTitle(
                                              'Interstitial Ad Id (Android)',
                                              context),
                                          getVerticalSpace(context, 10),
                                          getTextFiledWidget(
                                              context,
                                              "Enter Interstitial ad id..",
                                              controller
                                                  .andInterstitialAdIdController),
                                        ],
                                      )),
                                  getHorizontalSpace(context, 20.h),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          itemSubTitle(
                                              'Interstitial Ad Id (ios)',
                                              context),
                                          getVerticalSpace(context, 10),
                                          getTextFiledWidget(
                                              context,
                                              "Enter Interstitial ad id..",
                                              controller
                                                  .iosInterstitialAdIdController),
                                        ],
                                      ))
                                ],
                              ),

                              // getVerticalSpace(context, 22),

                              getVerticalSpace(context, 22),

                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      itemSubTitle(
                                          'Terms And Conditions', context),
                                      getVerticalSpace(context, 10),
                                      getTextFiledWidget(
                                          context,
                                          "https://google.com",
                                          controller.termLinkController),
                                    ],
                                  )),
                                  getHorizontalSpace(context, 20.h),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      itemSubTitle('Privacy policy', context),
                                      getVerticalSpace(context, 10),
                                      getTextFiledWidget(
                                          context,
                                          "https://google.com",
                                          controller.privacyLinkController),
                                    ],
                                  ))
                                ],
                              ),

                              getVerticalSpace(context, 22),

                              // Row(
                              //   children: [
                              //     Expanded(child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         itemSubTitle('Privacy policy', context),
                              //         getVerticalSpace(context, 10), getTextFiledWidget(
                              //             context, "https://google.com", controller.privacyLinkController),
                              //       ],
                              //     ))
                              //   ],
                              // ),
                              // getVerticalSpace(context, 22),

                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      itemSubTitle('About us', context),
                                      getVerticalSpace(context, 10),
                                      Container(
                                        decoration: getDefaultDecoration(
                                            radius: getDefaultRadius(context),
                                            // bgColor: getReportColor(context),
                                            borderColor:
                                                getBorderColor(context),
                                            borderWidth: 1),
                                        child: Column(
                                          children: [
                                            getVerticalSpace(context, 10),
                                            Container(
                                              decoration: getDefaultDecoration(
                                                  radius:
                                                      getDefaultRadius(context),
                                                  bgColor:
                                                      getCardColor(context),
                                                  borderColor:
                                                      getBorderColor(context),
                                                  borderWidth: 1),
                                              child: QuillToolbar.basic(
                                                  iconTheme: QuillIconTheme(
                                                      iconUnselectedFillColor:
                                                          Colors.transparent),
                                                  controller: controller
                                                      .aboutController),
                                            ),
                                            Container(
                                              child: QuillEditor.basic(
                                                controller:
                                                    controller.aboutController,

                                                readOnly:
                                                    false, // true for view only mode
                                              ).paddingSymmetric(
                                                  vertical: 15.h,
                                                  horizontal: 15),
                                            ).marginSymmetric(vertical: 15.h),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                  // Expanded(child: Container())
                                ],
                              ),

                              getVerticalSpace(context, 22),

                              itemSubTitle('Welcome Logo', context),
                              getVerticalSpace(context, 10),

                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 100.h,
                                    decoration: getDefaultDecoration(
                                      // borderColor: borderColor,
                                      radius: 12.h,
                                    ),
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      strokeWidth: 0.8,
                                      color: darkBorderColor,
                                      dashPattern: [8, 4],
                                      radius: Radius.circular(12.h),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: double.infinity,
                                            width: 120.h,
                                            margin: EdgeInsets.all(12.h),
                                            decoration: getDefaultDecoration(
                                                bgColor:
                                                    getReportColor(context),
                                                radius: getResizeRadius(
                                                    context, 16)),
                                            child: Obx(() => (controller
                                                    .isImageOffline.value)
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            getResizeRadius(
                                                                context, 16)),
                                                    //add border radius
                                                    child: Image.memory(
                                                      controller.webImage,
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  )
                                                : model.image!.isNotEmpty
                                                    ? Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    getResizeRadius(
                                                                        context,
                                                                        16)),
                                                            //add border radius
                                                            child:
                                                                Image.network(
                                                              model.image ?? "",
                                                              height: double
                                                                  .infinity,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  // GestureDetector(
                                                                  //   onTap: (){
                                                                  //
                                                                  //
                                                                  //   },
                                                                  //   child: Container(
                                                                  //       margin: EdgeInsets.all(
                                                                  //           8.h),
                                                                  //       height: 22.h,
                                                                  //       width: 22.h,
                                                                  //       decoration:
                                                                  //       BoxDecoration(
                                                                  //           color: darkBorderColor,
                                                                  //           shape: BoxShape
                                                                  //               .circle),
                                                                  //       child: Center(
                                                                  //         child: imageSvg(
                                                                  //             "close.svg",
                                                                  //             height: 8.h,
                                                                  //             width: 8.h,),
                                                                  //       )),
                                                                  // ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    : Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          // Container(
                                                          //     margin: EdgeInsets.all(
                                                          //         10.h),
                                                          //     height: 22.h,
                                                          //     width: 22.h,
                                                          //     decoration:
                                                          //     BoxDecoration(
                                                          //         color: darkBorderColor,
                                                          //         shape: BoxShape
                                                          //             .circle),
                                                          //     child: Center(
                                                          //       child: imageSvg(
                                                          //           "close.svg",
                                                          //           height: 8.h,
                                                          //           width: 8.h,),
                                                          //     )),

                                                          Center(
                                                            child: imageAsset(
                                                              "gallery.png",
                                                              height: 32.h,
                                                              width: 32.h,
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: getImageTextFiledWidget(
                                                context,
                                                "Upload a file",
                                                controller.imageController,
                                                isEnabled: false,
                                                child: getButtonWidget(
                                                  context,
                                                  'Browse',
                                                      () {
                                                    controller.imgFromGallery();
                                                  },
                                                  textColor: getSubFontColor(context),
                                                  bgColor: getReportColor(context),
                                                  horPadding: 22.h,
                                                  horizontalSpace: 0,
                                                  verticalSpace:
                                                  0,
                                                  btnHeight: 35.h,
                                                )

                                                // InkWell(
                                                //   onTap: () {
                                                //     controller.imgFromGallery();
                                                //   },
                                                //
                                                //   child: Container(
                                                //     height: double.infinity,
                                                //     alignment: Alignment.center,
                                                //     // margin: EdgeInsets.only(left: 7.h),
                                                //     margin: EdgeInsets.all(4.h),
                                                //     padding: EdgeInsets.symmetric(
                                                //         horizontal: 30.h, vertical: 10.h),
                                                //     decoration: getDefaultDecoration(
                                                //         bgColor: (themeController.isDarkTheme.value)?getReportColor(context):lightPrimaryColor,
                                                //         radius: 12.r),
                                                //     child: getTextWidget(
                                                //       context,
                                                //       'Browse',
                                                //       40,
                                                //       getSubFontColor(context),
                                                //       customFont: "",
                                                //       fontWeight: FontWeight.w600,
                                                //     ),
                                                //   ),
                                                // )
                                                ),
                                          ),
                                          getHorizontalSpace(context, 10),
                                        ],
                                      ),
                                    ),
                                  )),

                                  // Expanded(
                                  //     child: Column(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     itemSubTitle('Story image', context),
                                  //     getVerticalSpace(context, 10),
                                  //     ,
                                  //   ],
                                  // )),

                                  getHorizontalSpace(context, 10),

                                  // Expanded(
                                  //   child: Align(
                                  //     alignment: Alignment.topLeft,
                                  //     child: Obx(() {
                                  //
                                  //       return ;
                                  //     }),
                                  //   ),
                                  // ),
                                ],
                              ),

                              getVerticalSpace(context, 22),

                              // Row(
                              //   children: [
                              //     itemSubTitle('App Icon', context),
                              //     // itemSubTitle('(Optional)', context,color: getSubFontColor(context)),
                              //   ],
                              // ),
                              //
                              // getVerticalSpace(context, 10),
                              // getTextFiledWidget(context, "No file chosen",
                              //     controller.imageController,
                              //     isEnabled: false,
                              //     child: InkWell(
                              //       onTap: () {
                              //         controller.imgFromGallery();
                              //       },
                              //       child: Container(
                              //         height: double.infinity,
                              //         alignment: Alignment.center,
                              //         margin: EdgeInsets.only(left: 7.h),
                              //         // margin: EdgeInsets.all(7.h),
                              //         padding: EdgeInsets.symmetric(
                              //             horizontal: 5.h, vertical: 5.h),
                              //         decoration: getDefaultDecoration(
                              //             bgColor: borderColor,
                              //             radius: getResizeRadius(context, 10)),
                              //         child: getTextWidget(
                              //           context,
                              //           'Choose file',
                              //           35,
                              //           primaryFontColor,
                              //           fontWeight: FontWeight.w600,
                              //         ),
                              //       ),
                              //     )),
                              // getVerticalSpace(context, 22),
                              //
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: Obx(() {
                              //     return (controller.isImageOffline.value)
                              //         ? ClipRRect(
                              //             borderRadius: BorderRadius.circular(
                              //                 (getResizeRadius(context, 35))),
                              //             //add border radius
                              //             child: Container(
                              //               height: 200.h,
                              //               width: 200.h,
                              //               child: Stack(
                              //                 children: [
                              //                   Image.memory(
                              //                     controller.webImage,
                              //                     height: 200.h,
                              //                     width: 200.h,
                              //                     fit: BoxFit.cover,
                              //                   ),
                              //                   Align(
                              //                     alignment: Alignment.topRight,
                              //                     child: InkWell(
                              //                       onTap: () {
                              //                         controller.webImage =
                              //                             Uint8List(10);
                              //
                              //                         controller.imageController
                              //                             .text = "";
                              //
                              //                         controller.isImageOffline
                              //                             .value = false;
                              //                       },
                              //                       child: Container(
                              //                           margin: EdgeInsets.all(
                              //                               10.h),
                              //                           height: 22.h,
                              //                           width: 22.h,
                              //                           decoration:
                              //                               BoxDecoration(
                              //                                   color: Colors
                              //                                       .white,
                              //                                   shape: BoxShape
                              //                                       .circle),
                              //                           child: Center(
                              //                             child: imageSvg(
                              //                                 "close.svg",
                              //                                 height: 8.h,
                              //                                 width: 8.h,
                              //                                 color:
                              //                                     primaryColor),
                              //                           )),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           )
                              //         //     :isEdit?
                              //         // ClipRRect(
                              //         //   borderRadius: BorderRadius.circular(
                              //         //       (getResizeRadius(
                              //         //           context, 35))), //add border radius
                              //         //   child: Image.network(
                              //         //     categoryModel!.image!,
                              //         //     height: 200.h,
                              //         //     width: 300.h,
                              //         //     fit: BoxFit.contain,
                              //         //   ),
                              //         // )
                              //         : Container();
                              //   }),
                              // ),

                              Row(
                                children: [
                                  Spacer(),


                                  Obx(() => getButtonWidget(
                                    context,
                                    'Submit',
                                    isProgress: controller.isLoading.value,
                                        ()  {

                                          PrefData.checkAccess(context: context, function: (){

                                            controller.editDetail(
                                                homeController, context, () {});
                                          });

                                    },
                                    horPadding: 22.h,
                                    horizontalSpace: 0,
                                    verticalSpace: 0,
                                    btnHeight: 40.h,
                                  )),
                                  // Expanded(child: Container())
                                ],
                              ),
                              getVerticalSpace(context, 30),
                            ],
                          );
                        },
                      );
                    } else {
                      print("Called---false");
                      return GetBuilder<SettingController>(
                        init: SettingController(),
                        builder: (controller) {
                          return (Responsive.isMobile(context))
                              ? ListView(
                                  children: [
                                    getVerticalSpace(context,
                                        (getCommonPadding(context) / 2)),
                                    itemSubTitle('App Name', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "Enter app name..",
                                        controller.appNameController),
                                    getVerticalSpace(context, 22),
                                    itemSubTitle(
                                        'App ad id (Android)', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "Enter app ad id..",
                                        controller.appAdIdController),
                                    getVerticalSpace(context, 22),
                                    itemSubTitle('App ad id (ios)', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "Enter app ad id..",
                                        controller.iosAppAdIdController),
                                    getVerticalSpace(context, 22),
                                    itemSubTitle(
                                        'Banner Ad Id (Android)', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "Enter banner ad id..",
                                        controller.andBannerAdIdController),
                                    getVerticalSpace(context, 22),
                                    itemSubTitle('Banner Ad Id (ios)', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "Enter banner ad id..",
                                        controller.iosBannerAdIdController),
                                    getVerticalSpace(context, 22),
                                    itemSubTitle('Interstitial Ad Id (Android)',
                                        context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "Enter Interstitial ad id..",
                                        controller
                                            .andInterstitialAdIdController),
                                    getVerticalSpace(context, 22),
                                    itemSubTitle(
                                        'Interstitial Ad Id (ios)', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "Enter Interstitial ad id..",
                                        controller
                                            .iosInterstitialAdIdController),
                                    getVerticalSpace(context, 22),
                                    Row(
                                      children: [
                                        itemSubTitle('App Icon', context),
                                        // itemSubTitle('(Optional)', context,color: getSubFontColor(context)),
                                      ],
                                    ),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "No file chosen",
                                        controller.imageController,
                                        isEnabled: false,
                                        child: InkWell(
                                          onTap: () {
                                            controller.imgFromGallery();
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(left: 4.h),
                                            // margin: EdgeInsets.all(7.h),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.h,
                                                vertical: 5.h),
                                            decoration: getDefaultDecoration(
                                                bgColor: borderColor,
                                                radius: getResizeRadius(
                                                    context, 10)),
                                            child: getTextWidget(
                                              context,
                                              'Choose file',
                                              40,
                                              primaryFontColor,
                                              customFont: "",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )),
                                    getVerticalSpace(context, 22),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Obx(() {
                                        return (controller.isImageOffline.value)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        (getResizeRadius(
                                                            context, 35))),
                                                //add border radius
                                                child: Container(
                                                  height: 200.h,
                                                  width: 200.h,
                                                  child: Stack(
                                                    children: [
                                                      Image.memory(
                                                        controller.webImage,
                                                        height: 200.h,
                                                        width: 200.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: InkWell(
                                                          onTap: () {
                                                            controller
                                                                    .webImage =
                                                                Uint8List(10);

                                                            controller
                                                                .imageController
                                                                .text = "";

                                                            controller
                                                                .isImageOffline
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets
                                                                  .all(10.h),
                                                              height: 22.h,
                                                              width: 22.h,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: Center(
                                                                child: imageSvg(
                                                                    "close.svg",
                                                                    height: 8.h,
                                                                    width: 8.h,
                                                                    color:
                                                                        primaryColor),
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            //     :isEdit?
                                            // ClipRRect(
                                            //   borderRadius: BorderRadius.circular(
                                            //       (getResizeRadius(
                                            //           context, 35))), //add border radius
                                            //   child: Image.network(
                                            //     categoryModel!.image!,
                                            //     height: 200.h,
                                            //     width: 300.h,
                                            //     fit: BoxFit.contain,
                                            //   ),
                                            // )
                                            : Container();
                                      }),
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        Obx(() => getButtonWidget(
                                              context,
                                              'Submit',
                                              isProgress:
                                                  controller.isLoading.value,
                                              () {
                                                // if(isEdit){
                                                // controller.editDetail(homeController, context, (){
                                                //
                                                // });
                                                // }else{
                                                controller.addDetail(
                                                    context, homeController,
                                                    () {
                                                  // controller.appNameController.text = "";
                                                  // controller.appAdIdController.text = "";
                                                  // controller.bannerAdIdController.text = "";
                                                  // controller.interstitialAdIdController.text = "";
                                                  // controller.webImage = Uint8List(10);
                                                  // controller.imageController.text = "";
                                                  // controller.isImageOffline.value = false;
                                                });
                                                // }
                                              },
                                              horPadding: 22.h,
                                              horizontalSpace: 0,
                                              verticalSpace: (controller
                                                      .isImageOffline.value)
                                                  ? 20.h
                                                  : 0,
                                              btnHeight: 40.h,
                                            )),
                                      ],
                                    ),
                                    getVerticalSpace(context, 30),
                                  ],
                                )
                              : ListView(
                                  children: [
                                    getVerticalSpace(context,
                                        (getCommonPadding(context) / 2)),
                                    itemSubTitle('App Name', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "Enter app name..",
                                        controller.appNameController),
                                    getVerticalSpace(context, 22),

                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                itemSubTitle(
                                                    'App ad id (Android)',
                                                    context),
                                                getVerticalSpace(context, 10),
                                                getTextFiledWidget(
                                                    context,
                                                    "Enter app ad id..",
                                                    controller
                                                        .appAdIdController),
                                              ],
                                            )),
                                        getHorizontalSpace(context, 20.h),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                itemSubTitle(
                                                    'App ad id (ios)', context),
                                                getVerticalSpace(context, 10),
                                                getTextFiledWidget(
                                                    context,
                                                    "Enter app ad id..",
                                                    controller
                                                        .iosAppAdIdController),
                                              ],
                                            )),
                                      ],
                                    ),

                                    // getVerticalSpace(context, 22),

                                    getVerticalSpace(context, 22),

                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                itemSubTitle(
                                                    'Banner Ad Id (Android)',
                                                    context),
                                                getVerticalSpace(context, 10),
                                                getTextFiledWidget(
                                                    context,
                                                    "Enter banner ad id..",
                                                    controller
                                                        .andBannerAdIdController),
                                              ],
                                            )),

                                        getHorizontalSpace(context, 20.h),

                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                itemSubTitle(
                                                    'Banner Ad Id (ios)',
                                                    context),
                                                getVerticalSpace(context, 10),
                                                getTextFiledWidget(
                                                    context,
                                                    "Enter banner ad id..",
                                                    controller
                                                        .iosBannerAdIdController),
                                              ],
                                            )),
                                      ],
                                    ),

                                    // getVerticalSpace(context, 22),

                                    getVerticalSpace(context, 22),

                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                itemSubTitle(
                                                    'Interstitial Ad Id (Android)',
                                                    context),
                                                getVerticalSpace(context, 10),
                                                getTextFiledWidget(
                                                    context,
                                                    "Enter Interstitial ad id..",
                                                    controller
                                                        .andInterstitialAdIdController),
                                              ],
                                            )),
                                        getHorizontalSpace(context, 20.h),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                itemSubTitle(
                                                    'Interstitial Ad Id (ios)',
                                                    context),
                                                getVerticalSpace(context, 10),
                                                getTextFiledWidget(
                                                    context,
                                                    "Enter Interstitial ad id..",
                                                    controller
                                                        .iosInterstitialAdIdController),
                                              ],
                                            )),
                                      ],
                                    ),

                                    // getVerticalSpace(context, 22),

                                    getVerticalSpace(context, 22),
                                    Row(
                                      children: [
                                        itemSubTitle('App Icon', context),
                                        // itemSubTitle('(Optional)', context,color: getSubFontColor(context)),
                                      ],
                                    ),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context,
                                        "No file chosen",
                                        controller.imageController,
                                        isEnabled: false,
                                        child: InkWell(
                                          onTap: () {
                                            controller.imgFromGallery();
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(left: 4.h),
                                            // margin: EdgeInsets.all(7.h),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.h,
                                                vertical: 5.h),
                                            decoration: getDefaultDecoration(
                                                bgColor: borderColor,
                                                radius: getResizeRadius(
                                                    context, 10)),
                                            child: getTextWidget(
                                              context,
                                              'Choose file',
                                              40,
                                              primaryFontColor,
                                              customFont: "",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )),
                                    getVerticalSpace(context, 22),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Obx(() {
                                        return (controller.isImageOffline.value)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        (getResizeRadius(
                                                            context, 35))),
                                                //add border radius
                                                child: Container(
                                                  height: 200.h,
                                                  width: 200.h,
                                                  child: Stack(
                                                    children: [
                                                      Image.memory(
                                                        controller.webImage,
                                                        height: 200.h,
                                                        width: 200.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: InkWell(
                                                          onTap: () {
                                                            controller
                                                                    .webImage =
                                                                Uint8List(10);

                                                            controller
                                                                .imageController
                                                                .text = "";

                                                            controller
                                                                .isImageOffline
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets
                                                                  .all(10.h),
                                                              height: 22.h,
                                                              width: 22.h,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: Center(
                                                                child: imageSvg(
                                                                    "close.svg",
                                                                    height: 8.h,
                                                                    width: 8.h,
                                                                    color:
                                                                        primaryColor),
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            //     :isEdit?
                                            // ClipRRect(
                                            //   borderRadius: BorderRadius.circular(
                                            //       (getResizeRadius(
                                            //           context, 35))), //add border radius
                                            //   child: Image.network(
                                            //     categoryModel!.image!,
                                            //     height: 200.h,
                                            //     width: 300.h,
                                            //     fit: BoxFit.contain,
                                            //   ),
                                            // )
                                            : Container();
                                      }),
                                    ),
                                    Row(
                                      children: [
                                        Obx(() => getButtonWidget(
                                              context,
                                              'Submit',
                                              isProgress:
                                                  controller.isLoading.value,
                                              () {
                                                // if(isEdit){
                                                // controller.editDetail(homeController, context, (){
                                                //
                                                // });
                                                // }else{
                                                controller.addDetail(
                                                    context, homeController,
                                                    () {
                                                  // controller.appNameController.text = "";
                                                  // controller.appAdIdController.text = "";
                                                  // controller.bannerAdIdController.text = "";
                                                  // controller.interstitialAdIdController.text = "";
                                                  // controller.webImage = Uint8List(10);
                                                  // controller.imageController.text = "";
                                                  // controller.isImageOffline.value = false;
                                                });
                                                // }
                                              },
                                              horPadding: 22.h,
                                              horizontalSpace: 0,
                                              verticalSpace: (controller
                                                      .isImageOffline.value)
                                                  ? 20.h
                                                  : 0,
                                              btnHeight: 40.h,
                                            )),
                                        Expanded(child: Container())
                                      ],
                                    ),
                                    getVerticalSpace(context, 30),
                                  ],
                                );
                        },
                      );
                    }
                  } else {
                    return getProgressWidget(context);
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}

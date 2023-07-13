import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/data/FirebaseData.dart';
import 'package:storyadminpanel/controller/notification_controller.dart';
import 'package:storyadminpanel/theme/app_theme.dart';
import 'package:storyadminpanel/ui/notification/notification_drop_down.dart';
import 'package:storyadminpanel/util/pref_data.dart';

import '../../controller/data/LoginData.dart';
import '../../controller/home_controller.dart';
import '../../main.dart';
import '../../model/story_model.dart';
import '../../theme/color_scheme.dart';
import '../common/common.dart';
import '../story/addStory/add_story_screen.dart';

class SendNotification extends StatefulWidget {
  final Function function;

  SendNotification({required this.function});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
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
            horizontal: getDefaultHorSpace(context),
            vertical: getDefaultHorSpace(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTextWidget(
                context, 'Send Notification', 75, getFontColor(context),
                fontWeight: FontWeight.w700),
            getVerticalSpace(context, 35),
            Expanded(
                child: getCommonContainer(
              context: context,
              verSpace: 0,
              child: GetBuilder<NotificationController>(
                init: NotificationController(),
                builder: (controller) {
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView(
                          children: [
                            getVerticalSpace(
                                context, (getCommonPadding(context) / 2)),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    itemSubTitle('Title', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(context, "Enter title..",
                                        controller.nameController),
                                  ],
                                )),
                                getHorizontalSpace(context, 20),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        itemSubTitle('Send Story', context),
                                        itemSubTitle('(Optional)', context,
                                            color: getSubFontColor(context)),
                                      ],
                                    ),
                                    getVerticalSpace(context, 10),
                                    Obx(() {
                                      return homeController
                                                  .storyListNotification
                                                  .length ==
                                              1
                                          ? getDisableDropDownWidget(
                                              context,
                                              homeController
                                                  .storyListNotification[0]
                                                  .name!,
                                            )
                                          : NotificationDropDown(
                                              homeController,
                                              value: homeController
                                                  .storyNotification.value,
                                              onChanged: (value) {
                                                if (value !=
                                                    homeController
                                                        .storyNotification
                                                        .value) {
                                                  homeController
                                                      .storyNotification(value);
                                                }
                                              },
                                            );
                                    }),

                                    // Row(
                                    //   children: [
                                    //     itemSubTitle('Image', context),
                                    //     itemSubTitle('(Optional)', context,color: getSubFontColor(context)),
                                    //   ],
                                    // ),
                                    //
                                    // getVerticalSpace(context, 10),
                                    // getTextFiledWidget(
                                    //     context, "No file chosen", controller.imageController,
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
                                  ],
                                ))
                              ],
                            ),
                            getVerticalSpace(context, 22),
                            itemSubTitle('Message', context),
                            getVerticalSpace(context, 10),
                            getMessageTextFiledWidget(
                                context,
                                "Enter message..",
                                controller.messageController),
                            getVerticalSpace(context, 22),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 112.h,
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
                                          width: 125.h,
                                          margin: EdgeInsets.all(8.h),
                                          decoration: getDefaultDecoration(
                                              bgColor: getReportColor(context),
                                              radius:
                                                  getResizeRadius(context, 16)),
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
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                              child: InkWell(
                                                onTap: () {
                                                  controller.imgFromGallery();
                                                },
                                                child: Container(
                                                  height: double.infinity,
                                                  alignment: Alignment.center,
                                                  // margin: EdgeInsets.only(left: 7.h),
                                                  margin: EdgeInsets.all(4.h),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30.h,
                                                      vertical: 0.h),
                                                  decoration: getDefaultDecoration(
                                                      bgColor: (themeController
                                                              .isDarkTheme
                                                              .value)
                                                          ? getReportColor(
                                                              context)
                                                          : lightPrimaryColor,
                                                      radius: 12.r),
                                                  child: getTextWidget(
                                                    context,
                                                    'Browse',
                                                    40,
                                                    getSubFontColor(context),
                                                    customFont: "",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )),
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
                            Row(
                              children: [
                                itemSubTitle('External Link', context),
                                itemSubTitle('(Optional)', context,
                                    color: getSubFontColor(context)),
                              ],
                            ),
                            getVerticalSpace(context, 10),
                            getTextFiledWidget(context, "https://google.com",
                                controller.linkController),
                            getVerticalSpace(context, 22),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Obx(() => getButtonWidget(
                                context,
                                'Submit',
                                isProgress: controller.isLoading.value,
                                () {
                                  // controller.isLoading.value = true;

                                  PrefData.checkAccess(
                                      context: context,
                                      function: () async {
                                        if (homeController
                                            .storyNotification.isNotEmpty) {
                                          StoryModel story =
                                              await FirebaseData.getStory(
                                                  homeController
                                                      .storyNotification.value);

                                          bool b =
                                              await sendNotificationWithStory(
                                                  context,
                                                  controller,
                                                  story,
                                                  homeController);

                                          print("notification=====${b}");

                                          if (b) {
                                            homeController
                                                .storyNotification.value = "";

                                            controller.clearAllData();

                                            showCustomToast(
                                                context: context,
                                                message:
                                                    "Notification send successfully");
                                          }
                                        } else {
                                          print("object----true");

                                          bool b = await sendNotification(
                                              context,
                                              controller,
                                              homeController);

                                          print("b--------------${b}");
                                          if (b) {
                                            showCustomToast(
                                                context: context,
                                                message:
                                                    "Notification send successfully");

                                            homeController
                                                .storyNotification.value = "";



                                            controller.clearAllData();
                                          }
                                        }
                                      });
                                },
                                horPadding: 22.h,
                                horizontalSpace: 0,
                                verticalSpace: 0,
                                btnHeight: 40.h,
                              )),
                        ],
                      ),
                      getVerticalSpace(context, 35),
                    ],
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<bool> sendNotification(BuildContext context,
      NotificationController controller, HomeController homeController) async {
    bool b = false;
    controller.isLoading.value = true;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("tokens").get();
    print("qu-===${querySnapshot.docs.length}");

    if (querySnapshot.docs.isNotEmpty) {
      if (controller.checkValidation(context)) {
         b = await sendNotificationByAdmin(querySnapshot.docs, controller);

        print("i===${b}");



      }
    }

    controller.isLoading.value = false;

    return b;
  }

  Future<bool> sendNotificationByAdmin(
      List<DocumentSnapshot> someInput, NotificationController controller) async {
    bool b = false;


    await Future.wait(someInput.map((input) async {
      Map data = input.data() as Map;
      if (data["token"] != null && data["token"].isNotEmpty) {
        b = await controller
            .sendFcmMessage(
            context,
            controller.nameController.text,
            controller.messageController.text,
            data["token"],
            controller.imageController.text);
      }
    }));




    return b;
  }

  Future<bool> sendNotificationWithStory(
      BuildContext context,
      NotificationController controller,
      StoryModel storyModel,
      HomeController homeController) async {
    controller.isLoading.value = true;
    bool b = false;

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("tokens").get();

    if (querySnapshot.docs.isNotEmpty) {
      b = await sendNotificationByAdmin(querySnapshot.docs, controller);
    }
    controller.isLoading.value = false;

    return b;
  }
}

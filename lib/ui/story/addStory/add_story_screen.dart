import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/home_controller.dart';
import 'package:storyadminpanel/model/story_model.dart';
import 'package:storyadminpanel/theme/app_theme.dart';
import 'package:storyadminpanel/theme/color_scheme.dart';
import 'package:storyadminpanel/ui/common/common.dart';
import 'package:storyadminpanel/ui/story/category_drop_down.dart';
import 'package:storyadminpanel/util/pref_data.dart';
import '../../../controller/data/FirebaseData.dart';
import '../../../controller/data/LoginData.dart';
import '../../../controller/story_controller.dart';
import '../../../main.dart';

class AddStoryScreen extends StatefulWidget {
  final Function function;
  final StoryModel? storyModel;

  AddStoryScreen({required this.function, this.storyModel});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  @override
  void initState() {
    super.initState();

    LoginData.getDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    double radius = getCommonRadius(context);
    double padding = getCommonPadding(context);

    HomeController homeController = Get.find();

    bool isEdit = widget.storyModel != null;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: getDefaultHorSpace(context),
            vertical: getDefaultHorSpace(context)),
        child: GetBuilder<StoryController>(
          init: StoryController(storyModel: widget.storyModel),
          builder: (controller) {
            return Column(
              children: [

                Row(
                  children: [
                    Expanded(
                      child: getTextWidget(
                          context,
                          isEdit ? 'Edit Story' : 'Add Story',
                          75,
                          getFontColor(context),
                          fontWeight: FontWeight.w700),
                      flex: 1,
                    ),
                  ],
                ),
                getVerticalSpace(context, 40),



                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: getDefaultDecoration(
                        bgColor: getCardColor(context), radius: radius),
                    padding: EdgeInsets.all(padding),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [



                        // (Responsive.isMobile(context))
                        //     ? Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           itemSubTitle('Story Title', context),
                        //           getVerticalSpace(context, 10),
                        //           getTextFiledWidget(context, "Enter title..",
                        //               controller.nameController),
                        //           getVerticalSpace(context, 30),
                        //           Row(
                        //             children: [
                        //               Expanded(
                        //                   child: Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   itemSubTitle('Select Category', context),
                        //                   getVerticalSpace(context, 10),
                        //                   Obx(() {
                        //                     return homeController
                        //                             .category.value.isNotEmpty
                        //                         ? homeController
                        //                                     .categoryList.length ==
                        //                                 1
                        //                             ? getDisableDropDownWidget(
                        //                                 context,
                        //                                 homeController
                        //                                     .categoryList[0].name!,
                        //                               )
                        //                             : CategoryDropDown(
                        //                                 homeController,
                        //                                 value: homeController
                        //                                     .category.value,
                        //                                 onChanged: (value) {
                        //                                   if (value !=
                        //                                       homeController
                        //                                           .category.value) {
                        //                                     homeController
                        //                                         .category(value);
                        //                                   }
                        //                                 },
                        //                               )
                        //                         : getDisableTextFiledWidget(
                        //                             context,
                        //                             homeController.isLoading.value
                        //                                 ? "Loading.."
                        //                                 : "No Data",
                        //                           );
                        //                   })
                        //                 ],
                        //               )),
                        //               getHorizontalSpace(context, 10),
                        //               Expanded(
                        //                   child: Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   itemSubTitle('Story Date', context),
                        //                   getVerticalSpace(context, 10),
                        //                   Obx(() => InkWell(
                        //                         child: getDisableTextFiledWidget(
                        //                           context,
                        //                           controller.date.value,
                        //                         ),
                        //                         onTap: () async {
                        //                           DateTime? pickedDate =
                        //                               await showDatePicker(
                        //                                   context: context,
                        //                                   initialDate:
                        //                                       controller.customDate,
                        //                                   //get today's date
                        //                                   firstDate: DateTime(2000),
                        //                                   //DateTime.now() - not to allow to choose before today.
                        //                                   lastDate: DateTime.now());
                        //
                        //                           if (pickedDate != null) {
                        //                             controller.customDate =
                        //                                 pickedDate;
                        //                             controller.date(controller
                        //                                 .formatter
                        //                                 .format(pickedDate));
                        //                           }
                        //                         },
                        //                       ))
                        //                 ],
                        //               )),
                        //             ],
                        //           ),
                        //           getVerticalSpace(context, 30),
                        //           itemSubTitle('Story', context),
                        //           getVerticalSpace(context, 10),
                        //           Container(
                        //             decoration: getDefaultDecoration(
                        //                 radius: radius,
                        //                 bgColor: getCardColor(context),
                        //                 borderColor: getBorderColor(context),
                        //                 borderWidth: 1),
                        //             child: Column(
                        //               children: [
                        //                 getVerticalSpace(context, 10),
                        //                 QuillToolbar.basic(
                        //                     controller: controller.descController),
                        //                 Container(
                        //                   child: QuillEditor.basic(
                        //                     controller: controller.descController,
                        //
                        //                     readOnly:
                        //                         false, // true for view only mode
                        //                   ).paddingSymmetric(
                        //                       vertical: 15.h, horizontal: 15),
                        //                 ).marginSymmetric(vertical: 15.h),
                        //               ],
                        //             ),
                        //           ),
                        //           getVerticalSpace(context, 30),
                        //           itemSubTitle('Audio', context),
                        //           getVerticalSpace(context, 10),
                        //           Obx(() => getTextFiledWidget(
                        //               context,
                        //               "No file chosen",
                        //               TextEditingController(
                        //                   text: controller.audioUrl.value),
                        //               isEnabled: false,
                        //               child: InkWell(
                        //                 onTap: () {
                        //                   controller.openFile();
                        //                 },
                        //                 child: Container(
                        //                   height: double.infinity,
                        //                   alignment: Alignment.center,
                        //                   margin: EdgeInsets.all(7.h),
                        //                   padding: EdgeInsets.symmetric(
                        //                       horizontal: 5.h, vertical: 5.h),
                        //                   decoration: getDefaultDecoration(
                        //                       bgColor: borderColor,
                        //                       radius: getResizeRadius(context, 10)),
                        //                   child: getTextWidget(
                        //                     context,
                        //                     'Choose file',
                        //                     35,
                        //                     primaryFontColor,
                        //                     fontWeight: FontWeight.w600,
                        //                   ),
                        //                 ),
                        //               ))),
                        //           getVerticalSpace(context, 30),
                        //           itemSubTitle('Story image', context),
                        //           getVerticalSpace(context, 10),
                        //           getTextFiledWidget(context, "No file chosen",
                        //               controller.imageController,
                        //               isEnabled: false,
                        //               child: InkWell(
                        //                 onTap: () {
                        //                   controller.imgFromGallery();
                        //                 },
                        //                 child: Container(
                        //                   height: double.infinity,
                        //                   alignment: Alignment.center,
                        //                   margin: EdgeInsets.all(7.h),
                        //                   padding: EdgeInsets.symmetric(
                        //                       horizontal: 5.h, vertical: 5.h),
                        //                   decoration: getDefaultDecoration(
                        //                       bgColor: borderColor,
                        //                       radius: getResizeRadius(context, 10)),
                        //                   child: getTextWidget(
                        //                     context,
                        //                     'Choose file',
                        //                     35,
                        //                     primaryFontColor,
                        //                     fontWeight: FontWeight.w600,
                        //                   ),
                        //                 ),
                        //               )),
                        //           getVerticalSpace(context, 35),
                        //           Align(
                        //             alignment: Alignment.topLeft,
                        //             child: Obx(() {
                        //               return (controller.isImageOffline.value)
                        //                   ? ClipRRect(
                        //                       borderRadius: BorderRadius.circular(
                        //                           (getResizeRadius(context,
                        //                               35))), //add border radius
                        //                       child: Image.memory(
                        //                         controller.webImage,
                        //                         height: 200.h,
                        //                         width: 300.h,
                        //                         fit: BoxFit.contain,
                        //                       ),
                        //                     )
                        //                   : isEdit
                        //                       ? ClipRRect(
                        //                           borderRadius: BorderRadius.circular(
                        //                               (getResizeRadius(context,
                        //                                   35))), //add border radius
                        //                           child: Image.network(
                        //                             widget.storyModel!.image!,
                        //                             height: 200.h,
                        //                             width: 300.h,
                        //                             fit: BoxFit.contain,
                        //                           ),
                        //                         )
                        //                       : Container();
                        //             }),
                        //           ),
                        //         ],
                        //       )
                        //
                        //
                        //
                        //
                        //
                        //     :

                        Column(
                                children: [
                                  Row(
                                    children: [
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Column(
                                      //     crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      //     children: [
                                      //       itemSubTitle('Story Id', context),
                                      //       getVerticalSpace(context, 10),
                                      //       getTextFiledWidget(
                                      //           context,
                                      //           "Enter id..",
                                      //           controller.storyIdController),
                                      //     ],
                                      //   ),
                                      // ),
                                      // getHorizontalSpace(context, 10),



                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            itemSubTitle('Story Title', context),
                                            getVerticalSpace(context, 10),
                                            getTextFiledWidget(
                                                context,
                                                "Enter title..",
                                                controller.nameController),
                                          ],
                                        ),
                                      ),
                                      getHorizontalSpace(context, 10),
                                      Expanded(
                                        flex: 3,
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          itemSubTitle('Select Category', context),
                                          getVerticalSpace(context, 10),
                                          Obx(() {
                                            return homeController
                                                    .category.value.isNotEmpty
                                                ? homeController
                                                            .categoryList.length ==
                                                        1
                                                    ? getDisableDropDownWidget(
                                                        context,
                                                        homeController
                                                            .categoryList[0].name!,
                                                      )
                                                    : CategoryDropDown(
                                                        homeController,
                                                        value: homeController
                                                            .category.value,
                                                        onChanged: (value) {
                                                          if (value !=
                                                              homeController
                                                                  .category.value) {
                                                            homeController
                                                                .category(value);
                                                          }
                                                        },
                                                      )
                                                : getDisableTextFiledWidget(
                                                    context,
                                                    homeController.isLoading.value
                                                        ? "Loading.."
                                                        : "No Data",
                                                  );
                                          })
                                        ],
                                      )),
                                    ],
                                  ),

                                  getVerticalSpace(context, 30),

                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            itemSubTitle('Audio (optional)', context),
                                            getVerticalSpace(context, 10),
                                            Obx(() => getChooseFileTextFiledWidget(
                                                context,
                                                "No file chosen",
                                                TextEditingController(
                                                    text: controller.audioUrl.value),
                                                isEnabled: false,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.openFile();
                                                  },
                                                  child: Container(
                                                    height: double.infinity,
                                                    alignment: Alignment.center,
                                                    // margin: EdgeInsets.only(left: 7.h),
                                                    margin: EdgeInsets.all(4.h),
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10.h,
                                                        vertical: 5.h),
                                                    decoration: getDefaultDecoration(
                                                        bgColor: (themeController.isDarkTheme.value)?getReportColor(context):lightPrimaryColor,
                                                        radius: getResizeRadius(
                                                            context, 12)),
                                                    child: getTextWidget(
                                                      context,
                                                      'Choose file',
                                                      40,
                                                      getSubFontColor(context),
                                                      customFont: "",
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ))),
                                          ],
                                        ),
                                      ),
                                      getHorizontalSpace(context, 10),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          itemSubTitle('Story Date', context),
                                          getVerticalSpace(context, 10),
                                          Obx(() => InkWell(
                                                child: getDisableTextFiledWidget(
                                                  context,
                                                  controller.date.value,
                                                ),
                                                onTap: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              controller.customDate,
                                                          //get today's date
                                                          firstDate: DateTime(2000),
                                                          //DateTime.now() - not to allow to choose before today.
                                                          lastDate: DateTime.now());

                                                  if (pickedDate != null) {
                                                    controller.customDate =
                                                        pickedDate;
                                                    controller.date(controller
                                                        .formatter
                                                        .format(pickedDate));
                                                  }
                                                },
                                              ))
                                        ],
                                      )),
                                    ],
                                  ),


                                ],
                              ),

                        getVerticalSpace(context, 30),

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
                                          width: 135.h,
                                          margin: EdgeInsets.all(8.h),
                                          decoration: getDefaultDecoration(
                                              bgColor: getReportColor(context),
                                              radius:
                                              getResizeRadius(context, 16)),
                                          child: Obx(() => (controller.isImageOffline.value)
                                              ? ClipRRect(
                                            borderRadius: BorderRadius
                                                .circular(getResizeRadius(context, 16)), //add border radius
                                            child: Image.memory(
                                              controller.webImage,
                                              height: double.infinity,
                                              width: double.infinity,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                              : isEdit
                                              ? ClipRRect(
                                            borderRadius: BorderRadius
                                                .circular(getResizeRadius(context, 16)), //add border radius
                                            child: Image.network(
                                              widget.storyModel!.image!,
                                              height: double.infinity,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
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
                                              child: InkWell(
                                                onTap: () {
                                                  controller.imgFromGallery();
                                                },
                                                child: Container(
                                                  height: double.infinity,
                                                  alignment: Alignment.center,
                                                  // margin: EdgeInsets.only(left: 7.h),
                                                  margin: EdgeInsets.all(5.h),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30.h, vertical: 0.h),
                                                  decoration: getDefaultDecoration(
                                                      bgColor: (themeController.isDarkTheme.value)?getReportColor(context):lightPrimaryColor,
                                                      radius: 12.r),
                                                  child: getTextWidget(
                                                    context,
                                                    'Browse',
                                                    40,
                                                    customFont: "",
                                                    getSubFontColor(context),
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

                        getVerticalSpace(context, 30),

                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    itemSubTitle('Story', context),
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
                                            decoration:
                                            getDefaultDecoration(
                                                radius:
                                                getDefaultRadius(
                                                    context),
                                                bgColor: getCardColor(
                                                    context),
                                                borderColor:
                                                getBorderColor(
                                                    context),
                                                borderWidth: 1),
                                            child: QuillToolbar.basic(
                                                iconTheme: QuillIconTheme(
                                                    iconUnselectedFillColor:
                                                    Colors.transparent),
                                                controller: controller
                                                    .descController),
                                          ),
                                          Container(
                                            height: 200.h,
                                            child: QuillEditor.basic(
                                              controller:
                                              controller.descController,

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
                          ],
                        ),

                        // getVerticalSpace(context, 30),

                        getVerticalSpace(context, 35),



                        Row(
                          children: [
                            Spacer(),
                            Obx(() => getButtonWidget(
                                  context,
                                  isEdit ? 'Update' : 'Add New Story',
                                  isProgress: controller.isLoading.value,
                                  () {
                                    if (isEdit) {
                                      controller.editStory(homeController, context,
                                          () {
                                        widget.function();
                                      });
                                    } else {
                                      PrefData.checkAccess(context: context, function: (){

                                        controller.addStory(context, homeController,
                                                () {
                                                  FirebaseData.refreshStoryData();
                                              widget.function();
                                            });

                                      });
                                    }
                                  },
                                  horPadding: 25.h,
                                  horizontalSpace: 0,
                                  verticalSpace: 0,
                                  btnHeight: 40.h,
                                )),

                          ],
                        ),
                        Obx(() => controller.isLoading.value
                            ? getProgressWidget(context)
                            : Container())
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

itemSubTitle(String s, BuildContext context, {Color? color}) {
  return getTextWidget(
    context,
    s,
    40,
    color == null ? getSubFontColor(context) : color,
    fontWeight: FontWeight.w500,
  );
}

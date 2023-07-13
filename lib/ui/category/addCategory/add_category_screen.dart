import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/category_controller.dart';
import 'package:storyadminpanel/controller/data/LoginData.dart';
import 'package:storyadminpanel/main.dart';
import 'package:storyadminpanel/model/category_model.dart';
import 'package:storyadminpanel/theme/app_theme.dart';
import 'package:storyadminpanel/theme/color_scheme.dart';
import 'package:storyadminpanel/ui/common/common.dart';
import 'package:storyadminpanel/util/pref_data.dart';

class AddCategoryScreen extends StatefulWidget {
  final Function function;
  final CategoryModel? categoryModel;

  AddCategoryScreen({required this.function,this.categoryModel});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {

  @override
  void initState() {
    super.initState();
    LoginData.getDeviceId();
  }

  @override
  Widget build(BuildContext context) {

    double radius = getCommonRadius(context);
    // double radius = getResizeRadius(context, 20);
    double padding = getCommonPadding(context);

    bool isEdit = widget.categoryModel != null;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: getDefaultHorSpace(context),
            vertical: getDefaultHorSpace(context)
        ),
        child: GetBuilder<CategoryController>(
          init: CategoryController(categoryModel: widget.categoryModel),
          builder: (controller) {
            return Column(
              children: [

                Row(
                  children: [
                    Expanded(
                      child: getTextWidget(
                          context,isEdit ? 'Edit Category' : 'Add Category', 75, getFontColor(context),
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
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (isWeb(context))
                                  ? Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [


                                        Expanded(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            itemSubTitle('Category name', context),
                                            getVerticalSpace(context, 10),

                                            getTextFiledWidget(
                                                context, "Enter here..", controller.nameController)

                                          ],
                                        )),


                                        getHorizontalSpace(context, 10),

                                        Expanded(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            itemSubTitle('Category image', context),
                                            getVerticalSpace(context, 10),
                                            getChooseFileTextFiledWidget(
                                                context, "No file chosen", controller.imageController,
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
                                                        horizontal: 10.h, vertical: 0.h),
                                                    decoration: getDefaultDecoration(
                                                        bgColor: (themeController.isDarkTheme.value)?getReportColor(context):lightPrimaryColor,
                                                        radius: getResizeRadius(context, 10)),
                                                    child: getTextWidget(
                                                      context,
                                                      'Choose file',
                                                      40,
                                                      getFontColor(context),
                                                      customFont: "",
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        )),


                                      ],
                                    ),

                                    getVerticalSpace(context, 32),


                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Obx(() {

                                              return (controller.isImageOffline.value)
                                                  ? ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    (getResizeRadius(
                                                        context, 35))), //add border radius
                                                child: Image.memory(
                                                  controller.webImage,
                                                  height: 232.h,
                                                  // width: 150.h,
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                                  :isEdit?
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    (getResizeRadius(
                                                        context, 35))), //add border radius
                                                child: Image.network(
                                                  widget.categoryModel!.image!,
                                                  height: 232.h,
                                                  // width: 150.h,
                                                  fit: BoxFit.contain,
                                                ),
                                              )
                                                  : Container();
                                            }),
                                          ),
                                        ),
                                        Expanded(child: Container())
                                      ],
                                    ),


                                  ],
                                ),
                              )

                                  : Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    itemSubTitle('Category name', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context, "Enter here..", controller.nameController),
                                    getVerticalSpace(context, 30),
                                    itemSubTitle('Category image', context),
                                    getVerticalSpace(context, 10),
                                    getTextFiledWidget(
                                        context, "No file chosen", controller.imageController,
                                        isEnabled: false,
                                        child: InkWell(
                                          onTap: () {
                                            controller.imgFromGallery();
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.only(left: 7.h),
                                            margin:  EdgeInsets.all(4.h),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.h, vertical: 0.h),
                                            decoration: getDefaultDecoration(
                                                bgColor: lightPrimaryColor,
                                                radius: getResizeRadius(context, 12)),
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
                                    getVerticalSpace(context, 20),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Obx(() {

                                        return (controller.isImageOffline.value)
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              (getResizeRadius(
                                                  context, 35))), //add border radius
                                          child: Image.memory(
                                            controller.webImage,
                                            height: 100.h,
                                            width: 150.h,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                            :isEdit?
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              (getResizeRadius(
                                                  context, 35))), //add border radius
                                          child: Image.network(
                                            widget.categoryModel!.image!,
                                            height: 100.h,
                                            width: 150.h,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                            : Container();
                                      }),
                                    ),

                                // Row(
                                //   children: [
                                //     Obx(() => getButtonWidget(
                                //       context,
                                //       isEdit?'Update':'Add New Category',
                                //       isProgress: controller.isLoading.value,
                                //           () {
                                //
                                //         if(isEdit){
                                //           controller.editCategory(context,(){
                                //             widget.function();
                                //           });
                                //         }else{controller.addCategory(context,(){
                                //           widget.function();
                                //         });
                                //         }
                                //       },
                                //
                                //       horPadding: 25.h,
                                //       horizontalSpace: 0,
                                //       verticalSpace: 0,
                                //       btnHeight: 30.h,
                                //     )),
                                //     Expanded(child: Container()),
                                //   ],
                                // )

                                  ],
                                ),
                              ),

                              // Obx(() => controller.isLoading.value? getProgressWidget(context):Container())

                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Spacer(),
                            Obx(() => getButtonWidget(
                              context,
                              isEdit?'Update':'Add New Category',
                              isProgress: controller.isLoading.value,
                                  () {

                                if(isEdit){
                                  controller.editCategory(context,(){
                                    widget.function();
                                  });
                                }else{
                                  PrefData.checkAccess(context: context, function: (){
                                    controller.addCategory(context,(){
                                      widget.function();
                                    });

                                  });
                                }
                              },

                              horPadding: 50.h,
                              horizontalSpace: 0,
                              verticalSpace: 0,
                              btnHeight: 40.h,
                            )),
                          ],
                        ),

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

  itemSubTitle(String s, BuildContext context) {
    return getTextWidget(
      context,
      s,
      40,
      getSubFontColor(context),
      fontWeight: FontWeight.w500,
    );
  }


}

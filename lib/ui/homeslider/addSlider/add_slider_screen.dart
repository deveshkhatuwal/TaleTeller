

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/home_controller.dart';
import 'package:storyadminpanel/model/story_model.dart';
import 'package:storyadminpanel/theme/color_scheme.dart';
import 'package:storyadminpanel/ui/common/common.dart';
import 'package:storyadminpanel/util/pref_data.dart';
import '../../../controller/data/LoginData.dart';
import '../../../controller/home_slider_controller.dart';
import '../story_drop_down.dart';

class AddSliderScreen extends StatefulWidget {
  final Function function;
  final StoryModel? storyModel;

  AddSliderScreen({required this.function, this.storyModel});

  @override
  State<AddSliderScreen> createState() => _AddSliderScreenState();
}

class _AddSliderScreenState extends State<AddSliderScreen> {

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

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: getDefaultHorSpace(context),
            vertical: getDefaultHorSpace(context)),
        child: GetBuilder<HomeSliderController>(
          init: HomeSliderController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTextWidget(context, 'Add Story To Slider',
                    75, getFontColor(context),
                    fontWeight: FontWeight.w700),

                getVerticalSpace(context, 40),


                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: getDefaultDecoration(
                        bgColor: getCardColor(context), radius: radius),
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListView(
                            shrinkWrap: true,
                            children: [

                              itemSubTitle('Select Story', context),
                              getVerticalSpace(context, 10),
                              Obx(() {
                                return homeController.story.value.isNotEmpty
                                    ? homeController.storyList.length == 1
                                        ? getDisableDropDownWidget(
                                            context,
                                            homeController.storyList[0].name!,
                                          )
                                        : StoryDropDown(
                                            homeController,
                                            value: homeController.story.value,
                                            onChanged: (value) {
                                              if (value !=
                                                  homeController.story.value) {
                                                homeController.story(value);
                                              }
                                            },
                                          )
                                    : getDisableTextFiledWidget(
                                        context,
                                        homeController.isLoading.value
                                            ? "Loading.."
                                            : "No Data",
                                      );
                              }),
                              getVerticalSpace(context, 30),

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
                                PrefData.checkAccess(context: context, function: (){
                                  controller.addSlider(context,homeController,(){
                                    widget.function();
                                  });
                                });
                              },
                              horPadding: 25.h,
                              horizontalSpace: 0,
                              verticalSpace: 0,
                              btnHeight: 40.h,
                            )),
                          ],
                        )
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
      getFontColor(context),
      fontWeight: FontWeight.w500,
    );
  }
}

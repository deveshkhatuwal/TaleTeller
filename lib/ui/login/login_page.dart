import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/main.dart';
import 'package:storyadminpanel/theme/color_scheme.dart';
import 'package:storyadminpanel/ui/common/common.dart';
import 'package:storyadminpanel/util/app_routes.dart';
import 'package:storyadminpanel/util/constants.dart';
import 'package:storyadminpanel/util/pref_data.dart';
import 'package:storyadminpanel/util/responsive.dart';

import '../../controller/data/LoginData.dart';
import '../../theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  RxBool isProgress = false.obs;

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    return WillPopScope(
      child: Scaffold(
        backgroundColor: getBackgroundColor(context),
        body: SafeArea(
          child: Container(
            child: Row(
              children: [

                Visibility(child: Expanded(child: Container(

                  color: "#D1F3FB".toColor(),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             getMaxLineFont(context, 'Stories', 150, getPrimaryColor(context),1,
                                 customFont: Constants.headerFontsFamily,fontWeight:FontWeight.w900),
                             getVerticalSpace(context, 15),
                             getTextWidget(context, 'An e-reader, also called an e-book reader or e-book device, is a mobile electronic device that is designed primarily for the purpose of reading digital e-books and periodicals.'
                                 , 45, textColor,
                                 textAlign: TextAlign.center,fontWeight:FontWeight.w500),
                           ],
                        ).marginSymmetric(horizontal: 200.h),
                      ),flex: 1,),
                      Expanded(child: Container(
                        margin: EdgeInsets.only(top: 150.h),
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(Constants.assetPath+'frame.png', height: double.infinity, ),
                      ),flex: 1,),
                    ],
                  ),

                )),visible: Responsive.isDesktop(context),),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getTextWidget(context, 'Login', 70, getFontColor(context),
                          fontWeight: FontWeight.bold,
                          customFont: Constants.displayFontsFamily),
                      Card(
                        color: getCardColor(context),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                getResizeRadius(context, 25))),
                        margin: EdgeInsets.symmetric(vertical: 30.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getVerticalSpace(context, 30),
                            getTextWidget(
                              context,
                              'Username',
                              40,
                              getFontColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                            getVerticalSpace(context, 15),
                            getDefaultTextFiledWidget(
                                context, "Username", emailController),
                            getVerticalSpace(context, 30),
                            getTextWidget(
                              context,
                              'Password',
                              40,
                              getFontColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                            getVerticalSpace(context, 15),
                            getPasswordTextFiledWidget(
                                context, "Password", passwordController,onSubmit: (value){
                              isProgress.value = true;
                              _login();

                            },),
                            getVerticalSpace(context, 30),
                            Obx(() {
                              return getButtonWidget(context, 'Log In', () {
                                isProgress.value = true;
                                _login();
                              },
                                  isProgress: isProgress.value,
                                  horizontalSpace: 0,
                                  bgColor: primaryColor,
                                  textColor: Colors.white,
                                  verticalSpace: 0);
                            }),
                            getVerticalSpace(context, 30),
                          ],
                        ).paddingSymmetric(horizontal: 30.h),
                      ),
                    ],
                  ).marginSymmetric(horizontal: Responsive.isDesktop(context)?200.h:15.h),
                  flex: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? 1
                      : 2,
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Constants.exitApp();
        return false;
      },
    );
  }

  getSideSpace() {
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? Expanded(
            child: Container(),
            flex: 1,
          )
        : Container().marginSymmetric(horizontal: 15.h);
  }

  void _login() async {
    bool isLoginComplete = await LoginData.login(
        password: passwordController.text, username: emailController.text,context: context);

    if (isLoginComplete) {
      isProgress.value = false;

      selectedAction.value = await PrefData.getAction();

      Constants.pushPage(KeyUtil.homePage, function: (value) {});
      passwordController.text = '';
      emailController.text = '';
    } else {
      isProgress.value = false;
      showCustomToast(
          message: "Something wrong", context: context, title: 'Error');
    }
  }
}

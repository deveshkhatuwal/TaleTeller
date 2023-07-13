import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/home_controller.dart';
import 'package:storyadminpanel/main.dart';
import 'package:storyadminpanel/ui/common/common.dart';
import 'package:storyadminpanel/ui/dashboard/dashboard_screen.dart';
import 'package:storyadminpanel/ui/home/sidemenu/side_menu.dart';
import 'package:storyadminpanel/ui/homeslider/addSlider/add_slider_screen.dart';
import 'package:storyadminpanel/ui/setting/setting_screen.dart';

import '../../controller/data/FirebaseData.dart';
import '../../controller/data/LoginData.dart';
import '../../theme/color_scheme.dart';
import '../../util/constants.dart';
import '../../util/login_button.dart';
import '../../util/pref_data.dart';
import '../../util/responsive.dart';
import '../category/addCategory/add_category_screen.dart';
import '../category/category_screen.dart';
import '../homeslider/home_slider_screen.dart';
import '../notification/send_notification.dart';
import '../story/addStory/add_story_screen.dart';
import '../story/story_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero,() {
      LoginData.getDeviceId();
    },);

  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);

    themeController.setThemeStatusBar(context);
    return WillPopScope(
        child: Container(
          child: Scaffold(
            key: _key,
            drawer: Responsive.isDesktop(context)
                ? null
                : SideMenu(function: (value) {

                  print("value------${value}");
                    changeAction(value);

                    // _key.currentState!.openEndDrawer();

                    // onTap(value);
                    // Navigator.pop(context);
                  }),
            backgroundColor: getBackgroundColor(context),
            appBar: AppBar(
              backgroundColor: getCardColor(context),
              title: getMaxLineFont(
                  context, 'Stories', 85, getPrimaryColor(context), 1,
                  customFont: Constants.headerFontsFamily,
                  fontWeight: FontWeight.w900),
              systemOverlayStyle: getBrightnessLight(),
              elevation: 0,
              toolbarHeight: 70.h,
              leading: Responsive.isDesktop(context)
                  ? Container(
                      width: 0,
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.sort_sharp,
                        color: getPrimaryColor(context),
                      ),
                      onPressed: () => _key.currentState!.openDrawer(),
                    ),
              leadingWidth: Responsive.isDesktop(context) ? 0 : 100.w,
              actions: [
                Container(
                  decoration: getDefaultDecoration(
                      borderColor: getBorderColor(context),
                      borderWidth: 0.5,
                      radius: getResizeRadius(context, 40)),
                  margin:
                      EdgeInsets.symmetric(vertical: 15.h,),
                  child: Row(
                    children: [
                      imageSvg('dark_mode.svg',
                          height: 20.h,
                          width: 20.h,
                          color: themeController.checkDarkTheme()
                              ? getPrimaryColor(context)
                              : getSubFontColor(context), onTap: () {
                        if (!themeController.checkDarkTheme()) {
                          themeController.changeTheme(context);
                        }
                      }),
                      Container(
                        height: 20.h,
                        color: getBorderColor(context),
                        width: 0.5,
                        margin: EdgeInsets.symmetric(horizontal: 15.h),
                      ),
                      imageSvg('light_mode.svg',
                          height: 20.h,
                          width: 20.h,
                          color: themeController.checkDarkTheme()
                              ? getSubFontColor(context)
                              : getPrimaryColor(context), onTap: () {
                        if (themeController.checkDarkTheme()) {
                          themeController.changeTheme(context);
                        }
                      }),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                ),
                GestureDetector(
                  onTap: (){
                    _showPopupMenu();
                  },
                  child: Container(
                          alignment: Alignment.center,
                          child: imageAsset(
                              themeController.checkDarkTheme()
                                  ? 'profile_dark.png'
                                  : 'profile.png',
                              height: 40.h,
                              width: 40.h))
                      .marginSymmetric(horizontal: 20.h),
                )
              ],
            ),
            body: SafeArea(
              child: Container(
                child: Row(
                  children: [
                    Responsive.isDesktop(context)
                        ? SideMenu(function: (value) {
                            changeAction(value);
                          },)
                        : Container(),
                    Expanded(
                        child: Container(
                      color: getBackgroundColor(context),
                      // child:  getTabWidget(),
                      child: Obx(() => getTabWidget()),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          onBackClick();
          return false;
        });
  }

  onBackClick() {
    int action = selectedAction.value;
    if (action != actionDashBoard) {

      if(mainActionList.contains(action)){
        changeAction(actionDashBoard);
      }else{
        changeAction(oldAction);
      }
    } else {
      Constants.exitApp();
    }
  }



  getTabWidget() {




    int action = selectedAction.value;

    if(dummyActionList.contains(action)){
      action = lastAction;
    }
    
    if (action == actionCategories) {

      PrefData.setAction(actionCategories);
      return CategoryScreen(function: () {
        changeAction(actionAddCategory);
      });
    } else if (action == actionAddCategory) {
      PrefData.setAction(actionAddCategory);

      return AddCategoryScreen(function: () {
        onBackClick();
      });
    } else if (action == actionEditCategory) {
      PrefData.setAction(actionEditCategory);
      return AddCategoryScreen(
        function: () {
          onBackClick();
        },
        categoryModel: homeController.categoryModel,
      );
    } else if (action == actionAddStory) {
      PrefData.setAction(actionAddStory);
      return AddStoryScreen(
        function: () {
          onBackClick();
        },
      );
    } else if (action == actionEditStory) {
      PrefData.setAction(actionEditStory);
      return AddStoryScreen(
        function: () {
          onBackClick();
        },
        storyModel: homeController.storyModel,
      );
    } else if (action == actionHomeSlider) {
      PrefData.setAction(actionHomeSlider);
      return HomeSliderScreen(
        function: () {
          changeAction(actionAddSlider);
        },
      );
    } else if (action == actionSendNotification) {
      PrefData.setAction(actionSendNotification);
      return SendNotification(
        function: () {
          changeAction(actionAddSlider);
        },
      );
    } else if (action == actionAddSlider) {
      PrefData.setAction(actionAddSlider);
      return AddSliderScreen(
        function: () {
          onBackClick();
        },
      );
    } else if (action == actionStories) {
      PrefData.setAction(actionStories);
      return StoryScreen(function: () {
        if (homeController.categoryList.length > 0) {
          changeAction(actionAddStory);
        } else {
          showCustomToast(context: context, message: 'No category found');
        }
      });
    }else if (action == actionSettings) {
      PrefData.setAction(actionSettings);
      return SettingScreen(function: () {

      });
    }else if(action == actionDashBoard){
      PrefData.setAction(actionDashBoard);
      return DashboardScreen(function: () {});
    }
  }


  void _showPopupMenu() async {
    double width = 150.w;

    double right = isWeb(context) ? 50.h : MediaQuery.of(context).size.width;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(50.w, 50.h, right, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      color: getCardColor(context),
      items: [
        // PopupMenuItem<String>(
        //     child: Container(
        //       width: width,
        //       child: DrawerListTile(
        //         title: "Edit Profile",
        //         iconData: Icons.account_circle_sharp,
        //         space: 0,
        //         press: () {
        //           // onTap(profilePage);
        //           Navigator.of(context).pop();
        //         },
        //       ),
        //     ),
        //     value: 'Edit Profile'),
        // PopupMenuItem<String>(
        //     child: Container(
        //       width: width,
        //       child: DrawerListTile(
        //         title: "Нәтиже",
        //         iconData: Icons.account_circle_sharp,
        //         space: 0,
        //         press: () {
        //           // onTap(reportPage);
        //           Navigator.of(context).pop();
        //         },
        //       ),
        //     ),
        //     value: 'Нәтиже'),
        PopupMenuItem<String>(
            child: Container(
              width: width,
              child: DrawerListTile(
                title: "Change Password",
                iconData: Icons.account_circle_sharp,
                space: 0,
                // child: SizedBox(
                //   width: 35.w,
                //   height: 31.h,
                //   child: FittedBox(
                //     fit: BoxFit.fill,
                //     child: Obx(() =>
                //         CupertinoSwitch(
                //           value: !themeController.checkDarkTheme(),
                //           onChanged: (value) {
                //             themeController.changeTheme(context);
                //             Navigator.of(context).pop();
                //           },
                //           thumbColor: Colors.white,
                //           activeColor: getPrimaryColor(context),
                //         )),
                //   ),
                // ),
                press: () {
                  PrefData.checkAccess(context: context,function: () {
                    _displayTextInputDialog(context);
                  });

                },
              ),
            ),
            value: 'Change Password'),
        PopupMenuItem<String>(
            child: Container(
              width: width,
              child: DrawerListTile(
                title: "Log Out",
                iconData: Icons.account_circle_sharp,
                space: 0,
                color: Colors.red,
                visibility: false,
                press: () {
                  // onTap(homePage);

                  // getCommonDialog(
                  //     context: context,
                  //     subTitle: "Log Out",
                  //     title: "Are you sure want to Log out ?",
                  //     function: () {
                  //       LoginData.sendLoginPage();
                  //     });


                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    // false = user must tap button, true = tap outside dialog
                    builder: (BuildContext dialogContext) {

                      return AlertDialog(
                        title: getTextWidget(context, 'Log Out', 70, getFontColor(context),
                            fontWeight: FontWeight.w600),

                        // getCustomFont("", getResizeFont(context, ), getFontColor(context), 1,fontWeight: FontWeight.w600),


                        content: getTextWidget(context, 'Are you sure want to Log out ?', 50, getFontColor(context),
                            fontWeight: FontWeight.w600,),


                        // getCustomFont("Are you sure want to Log out ?", getResizeFont(context, 50), getFontColor(context), 1),


                        actions: <Widget>[
                          TextButton(
                            child: getTextWidget(context, 'YES', 50, getPrimaryColor(context),
                              fontWeight: FontWeight.w500,),

                            // getCustomFont("YES", getResizeFont(context, 50), getPrimaryColor(context), 1,fontWeight: FontWeight.w500),
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop();




                              LoginData.sendLoginPage();
                            },
                          ),
                          TextButton(
                            child:


                            getTextWidget(context, 'NO', 50, getPrimaryColor(context),
                              fontWeight: FontWeight.w500,),

                            // getCustomFont("NO", getResizeFont(context, 50), getPrimaryColor(context), 1,fontWeight: FontWeight.w500),
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop();

                              Navigator.of(dialogContext)
                                  .pop();

                              // Dismiss alert dialog
                            },
                          ),
                        ],
                      );
                    },
                  );

                  // LoginData.sendLoginPage();

                  // loginController.logout();
                  // Get.toNamed(KeyUtil.loginWidget);


                },
              ),
            ),
            value: 'Log Out'),
      ],
      elevation: 1.0,
    );
  }


  Future<void> _displayTextInputDialog(BuildContext context) async {
    TextEditingController _textFieldController = TextEditingController();
    TextEditingController _textFieldController1 = TextEditingController();
    // print("res===${res.Responsive.isSmallDesktop(context)}====${res.Responsive.isDesktop(context)}");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            // getTextWidget(context, 'NO', 50, getPrimaryColor(context),
            //   fontWeight: FontWeight.w500,),
            title: getTextWidget(context,'Change Password',70,getFontColor(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            backgroundColor: getBackgroundColor(context),

            contentPadding: EdgeInsets.zero,



            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.h,vertical: 15.h),
              width: Responsive.isDesktop(context) ||Responsive.isDesktop(context)? 450.h: double.infinity,

              // decoration: getDefaultDecoration(
              //     bgColor: getBackgroundColor(context),
              //     radius: 10.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Expanded(child: getTextWidget(context,'Change Password',0,getFontColor(context)),),


                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          size: 20.h,
                          color: getFontColor(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),

                  Text(
                    'New Password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),

                  getTextFiledWidget(context, "New Password", _textFieldController,),
                  // getCustomTextFiled('',
                  //     textEditingController:
                  //     _textFieldController,
                  //     context: context,
                  //     hint: 'New Password',
                  //     color: getCardColor(context),
                  //     iconData: Icons.lock_outline,
                  //     isPassword: true),



                  // TextField(
                  //   onChanged: (value) {},
                  //   obscureText: true,
                  //   controller: _textFieldController,
                  //   decoration: InputDecoration(hintText: "New Password"),
                  // ),
                  SizedBox(
                    height: 18.h,
                  ),


                  Text(
                    'Confirm Password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),

                  getTextFiledWidget(context, "Confirm Password", _textFieldController1,),

                  // getCustomTextFiled('',
                  //     textEditingController:
                  //     _textFieldController1,
                  //     context: context,
                  //     hint: 'Confirm Password',
                  //     color: getCardColor(context),
                  //     iconData: Icons.lock_outline,
                  //     isPassword: true),

                  SizedBox(
                    height: 25.h,
                  ),

                  LoginButton(onChanged: () async {

                    String password1 = _textFieldController.text;
                    String password2 = _textFieldController1.text;
                    if (isNotEmpty(password1) && isNotEmpty(password2)) {
                      if (password1.length > 6) {
                        if (password1 == password2) {
                          FirebaseData.changePassword(
                              password: password1,
                              function: () {
                                Get.back();
                              }, context: context);
                        } else {
                          showCustomToast(context: context,message: "Password does not match");
                        }
                      } else {
                        showCustomToast(context: context,message: "You must have 6 characters in your password");
                      }
                    } else {
                      showCustomToast(context: context,message: "Fill Detail..");
                    }

                  },title: 'Update',context:context),

                  SizedBox(
                    height: 25.h,
                  ),

                  // TextField(
                  //   obscureText: true,
                  //   onChanged: (value) {},
                  //   controller: _textFieldController1,
                  //   decoration: InputDecoration(hintText: "Confirm Password"),
                  // ),
                ],
              ),
            ),
            // actions: <Widget>[
            //   TextButton(
            //     child: getFont('Cancel', style: TextStyle(color: primaryColor)),
            //     onPressed: () {
            //       Get.back();
            //     },
            //   ),
            //   TextButton(
            //     child: getFont('Ok', style: TextStyle(color: primaryColor)),
            //     onPressed: () async {
            //       String password1 = _textFieldController.text;
            //       String password2 = _textFieldController1.text;
            //       if (isNotEmpty(password1) && isNotEmpty(password2)) {
            //         if (password1.length > 6) {
            //           if (password1 == password2) {
            //             FirebaseData.changePassword(
            //                 password: password1,
            //                 function: () {
            //                   Get.back();
            //                 });
            //           } else {
            //             showToast("Password does not match");
            //           }
            //         } else {
            //           showToast("You must have 6 characters in your password");
            //         }
            //       } else {
            //         showToast("Fill Detail..");
            //       }
            //     },
            //   ),
            // ],
          );
        });
  }






}

int oldAction = actionDashBoard;
int lastAction = actionDashBoard;

changeAction(int action) {
  oldAction = selectedAction.value;


  if(!dummyActionList.contains(oldAction)){
    lastAction = oldAction;
  }


  selectedAction(action);
}


class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.iconData,
    required this.press,
    this.visibility,
    this.color,
    this.space,
    this.child,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final VoidCallback press;
  final Color? color;
  final Widget? child;
  final double? space;
  final bool? visibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 25.h,
          ),
          child: InkWell(
            onTap: () {
              press();
            },
            child: Row(
              children: [
                Expanded(
                    child: getMaxLineFont(context, title, 50,
                        color == null ? getFontColor(context) : color!, 1,
                        fontWeight: FontWeight.w500)),
                child == null ? Container() : child!
              ],
            ),
          ),
        ),
        Visibility(
          visible: (visibility == null) ? true : visibility!,
          child: Container(
            color: getBorderColor(context),
            width: double.infinity,
            height: 0.5,
          ),
        )
      ],
    ).marginSymmetric(horizontal: space == null ? 35.w : space!);
  }
}




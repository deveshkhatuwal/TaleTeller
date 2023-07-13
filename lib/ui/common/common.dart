
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storyadminpanel/theme/app_theme.dart';

import '../../main.dart';
import '../../theme/color_scheme.dart';
import '../../util/constants.dart';
import '../../util/responsive.dart';

Widget getVerticalSpace(BuildContext context, double value) {
  if (Responsive.isTablet(context)) {
    return (value.h * 1.7).verticalSpace;
  }
  return value.h.verticalSpace;
}

getShimmerWidget(BuildContext context, Widget child) {
  if (themeController.isDarkTheme.value) {
    return Shimmer.fromColors(
      baseColor: Colors.white24,
      highlightColor: Colors.white12,
      child: child,
    );
  } else {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade200,
      child: child,
    );
  }
}


Widget getTextWidget(
    BuildContext context, String text, double fontSize, Color fontColor,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    String? customFont,
    txtHeight}) {
  return Text(
    text,
    style: TextStyle(
        decoration: decoration,
        fontSize: getResizeFont(context, fontSize),
        color: fontColor,
        fontFamily: customFont == null ? Constants.fontsFamily : customFont,
        fontWeight: fontWeight),
    softWrap: true,
    textAlign: textAlign,
  );
}

Widget getMaxLineFont(BuildContext context, String text, double fontSize,
    Color fontColor, int maxLine,
    {TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    String? customFont,
    String? font,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: getResizeFont(context, fontSize),
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: customFont == null ? Constants.fontsFamily : customFont,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}

separatorBuilder(BuildContext context, {RxString? queryText, String? value}) {
  bool cell = true;

  if (queryText != null && value != null) {
    if (queryText.value.isNotEmpty && !value.contains(queryText.value)) {
      cell = false;
    }
  }

  return Container(
    height: 0.5,
    width: double.infinity,
    color: cell ? getBorderColor(context) : Colors.transparent,
    margin: EdgeInsets.symmetric(vertical: 4.h),
  );
}

Widget imageAsset(String icon,
    {required double height,
    required double width,
    Color? color,
    BoxFit? boxFit}) {
  return Image.asset(
    Constants.assetPath + icon,
    height: height,
    width: width,
    color: color == null ? null : color,
    fit: boxFit == null ? null : boxFit,
  );
}

getDefaultHorSpace(BuildContext context) {
  if (Responsive.isDesktop(context)) {
    return 30.w;
  } else if (Responsive.isTablet(context)) {
    return 12.w;
  } else if (Responsive.isMobile(context)) {
    return 30.w;
  } else {
    return 15.w;
  }
}

getBrightnessLight() {
  return themeController.checkDarkTheme()
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;
}

DecorationImage getDecorationNetworkImage(
    BuildContext buildContext, String image,
    {BoxFit fit = BoxFit.contain}) {
  return DecorationImage(
    image: NetworkImage(image),
    fit: fit,
  );
}

Widget imageSvg(String icon,
    {required double height,
    required double width,
    Color? color,
    String? folder,
    Function? onTap,
    BoxFit? boxFit}) {
  print("folft===$folder");
  return GestureDetector(
    child: SvgPicture.asset(
      folder == null ? Constants.assetSvgPath + icon : folder + icon,
      height: height,
      width: width,
      color: color == null ? null : color,
    ),
    onTap: () {
      if (onTap != null) {
        onTap();
      }
    },
  );
}

getCommonDialog(
    {required BuildContext context,
    required String title,
    required String subTitle,
    required Function function}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(subTitle),
        content: Text(title),
        actions: <Widget>[
          new TextButton(
            child: new Text('No',
                style: TextStyle(color: getPrimaryColor(context))),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          new TextButton(
            child: new Text('Yes',
                style: TextStyle(color: getPrimaryColor(context))),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    },
  ).then((value) {
    if (value) {
      function();
    }
  });
}

Widget getDefaultTextFiledWidget(
  BuildContext context,
  String s,
  TextEditingController textEditingController, {
  bool? isEnabled,
  var inputType,
  var inputFormatters,
  var onChanged,
}) {
  double height = getDefaultButtonSize(context);
  double radius = getDefaultRadius(context);
  double fontSize = getResizeFont(context, 45);

  return Container(
    height: height,
    alignment: Alignment.center,
    decoration: getDefaultDecoration(
        radius: radius,
        bgColor: getSubCardColor(context),
        borderColor: getBorderColor(context),
        borderWidth: 1),
    child: TextFormField(
      maxLines: 1,
      onTap: () {},
      enabled: (isEnabled != null) ? isEnabled : true,
      controller: textEditingController,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: (inputType != null) ? inputType : null,
      inputFormatters: (inputFormatters != null) ? inputFormatters : null,
      onChanged: (onChanged != null) ? onChanged : null,
      style: TextStyle(
          fontFamily: Constants.fontsFamily,
          color: getFontColor(context),
          fontWeight: FontWeight.w400,
          fontSize: fontSize),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 25.w),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: s,
          isDense: false,
          hintStyle: TextStyle(
              fontFamily: Constants.fontsFamily,
              color: getSubFontColor(context),
              fontWeight: FontWeight.w400,
              fontSize: fontSize)),
    ),
  );
}

String decode(String codeUnits) {
  var unescape = HtmlUnescape();

  codeUnits = codeUnits.replaceAll("<pre>", '');
  codeUnits = codeUnits.replaceAll("</pre>", '');
  codeUnits = codeUnits.replaceAll("<p>", '');
  codeUnits = codeUnits.replaceAll("</p>", '');
  String singleConvert = unescape
      .convert(codeUnits.replaceAll("\\n\\n", "<br>"))
      .replaceAll("\\n", "<br>");
  return unescape.convert(singleConvert);
}

Widget getTextFiledWidget(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool? isEnabled,
    var inputType,
    var inputFormatters,
    var onChanged,
    // Function? function,
    Widget? child}) {
  double height = 58.h;

  if (Responsive.isTablet(context)) {
    height = 55.h;
  }

  double radius = getDefaultRadius(context);
  double fontSize = getResizeFont(context, 40);

  Widget textFiled = TextFormField(
    maxLines: 1,
    onTap: () {},
    enabled: (isEnabled != null) ? isEnabled : true,
    controller: textEditingController,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    keyboardType: (inputType != null) ? inputType : null,
    inputFormatters: (inputFormatters != null) ? inputFormatters : null,
    onChanged: (onChanged != null) ? onChanged : null,
    style: TextStyle(
        fontFamily: Constants.fontsFamily,
        color: getFontColor(context),
        fontWeight: FontWeight.w400,
        fontSize: fontSize),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.h, bottom: 18.h, top: 2.h),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide: BorderSide(
              color: getPrimaryColor(context),
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide: BorderSide(
              color: getBorderColor(context),
            )
        ),
        errorBorder: InputBorder.none,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide: BorderSide(
              color: getBorderColor(context),
            )
        ),
        // suffixIcon: (child != null)?Container(
        //   height: height,
        //   width: 112.h,
        //   child: child,
        // ):null,
        // suffixIcon: Container(height: height,child: child),
        // filled: true,
        // fillColor: getReportColor(context),
        focusColor: Colors.green,
        hintText: s,
        isDense: false,
        // suffix: child,
        hintStyle: TextStyle(
            fontFamily: Constants.fontsFamily,
            color: getSubFontColor(context),
            fontWeight: FontWeight.w400,
            fontSize: fontSize)),
  );

  return Container(
    height: height,
    alignment: Alignment.center,
    decoration: getDefaultDecoration(
        radius: radius,
        // bgColor: getReportColor(context),
        // borderColor: getBorderColor(context),
        borderWidth: 1
    ),
    child: child == null
        ? textFiled
        : Row(
            children: [Expanded(child: textFiled), child],
          ),
  );

  // return  child == null
  //     ? textFiled
  //     : Row(
  //   children: [Expanded(child: textFiled), Container(height: height,child: child)],
  // );
}




Widget getChooseFileTextFiledWidget(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool? isEnabled,
      var inputType,
      var inputFormatters,
      var onChanged,
      // Function? function,
      Widget? child}) {
  double height = 50.h;

  if (Responsive.isTablet(context)) {
    height = 55.h;
  }

  double radius = getDefaultRadius(context);
  double fontSize = getResizeFont(context, 40);

  Widget textFiled = TextFormField(
    maxLines: 1,
    onTap: () {},
    enabled: (isEnabled != null) ? isEnabled : true,
    controller: textEditingController,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.top,
    keyboardType: (inputType != null) ? inputType : null,
    inputFormatters: (inputFormatters != null) ? inputFormatters : null,
    onChanged: (onChanged != null) ? onChanged : null,
    style: TextStyle(
        fontFamily: Constants.fontsFamily,
        color: getFontColor(context),
        fontWeight: FontWeight.w400,
        fontSize: fontSize),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.h, bottom: 0.h, top: 0.h),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide: BorderSide(
              color: getPrimaryColor(context),
            )),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(radius)),
        //     borderSide: BorderSide(
        //       color: getBorderColor(context),
        //     )
        // ),
        errorBorder: InputBorder.none,
        // disabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(radius)),
        //     borderSide: BorderSide(
        //       color: getBorderColor(context),
        //     )
        // ),
        // suffixIcon: (child != null)?Container(
        //   height: height,
        //   width: 112.h,
        //   child: child,
        // ):null,
        // suffixIcon: Container(height: height,child: child),
        // filled: true,
        // fillColor: getReportColor(context),
        focusColor: Colors.green,
        hintText: s,
        isDense: false,
        // suffix: child,
        hintStyle: TextStyle(
            fontFamily: Constants.fontsFamily,
            color: getSubFontColor(context),
            fontWeight: FontWeight.w400,
            fontSize: fontSize)),
  );

  return Container(
    height: height,
    alignment: Alignment.center,
    decoration: getDefaultDecoration(
        radius: radius,
        // bgColor: getReportColor(context),
        borderColor: getBorderColor(context),
        borderWidth: 1
    ),
    child: child == null
        ? textFiled
        : Row(
      children: [Expanded(child: textFiled), child],
    ),
  );

  // return  child == null
  //     ? textFiled
  //     : Row(
  //   children: [Expanded(child: textFiled), Container(height: height,child: child)],
  // );
}





Widget getImageTextFiledWidget(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool? isEnabled,
    var inputType,
    var inputFormatters,
    var onChanged,
    // Function? function,
    Widget? child}) {
  double height = 45.h;

  if (Responsive.isTablet(context)) {
    height = 55.h;
  }

  double fontSize = getResizeFont(context, 40);

  Widget textFiled = TextFormField(
    maxLines: 1,
    onTap: () {},
    enabled: (isEnabled != null) ? isEnabled : true,
    controller: textEditingController,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    keyboardType: (inputType != null) ? inputType : null,
    inputFormatters: (inputFormatters != null) ? inputFormatters : null,
    onChanged: (onChanged != null) ? onChanged : null,
    style: TextStyle(
        fontFamily: Constants.fontsFamily,
        color: getFontColor(context),
        fontWeight: FontWeight.w400,
        fontSize: fontSize),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.h, bottom: 18.h, top: 2.h),
        border: InputBorder.none,
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(radius)),
        //     borderSide: BorderSide(
        //       color: getPrimaryColor(context),
        //     )),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(radius)),
        //     borderSide: BorderSide(
        //       color: borderColor,
        //     )
        // ),
        errorBorder: InputBorder.none,
        // disabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(radius)),
        //     borderSide: BorderSide(
        //       color: borderColor,
        //     )
        // ),
        // suffixIcon: (child != null)?Container(
        //   height: height,
        //   width: 112.h,
        //   child: child,
        // ):null,
        // suffixIcon: Container(height: height,child: child),
        // filled: true,
        // fillColor: getReportColor(context),
        focusColor: Colors.green,
        hintText: s,
        isDense: false,
        // suffix: child,
        hintStyle: TextStyle(
            fontFamily: Constants.fontsFamily,
            color: getSubFontColor(context),
            fontWeight: FontWeight.w400,
            fontSize: fontSize)),
  );

  return Container(
    height: height,

    child: child == null
        ? textFiled
        : Row(
            children: [Expanded(child: textFiled), child],
          ),
  );

  // return child == null
  //     ? textFiled
  //     : Row(
  //   children: [Expanded(child: textFiled), Container(height: height,child: child)],
  // );

}

Widget getMessageTextFiledWidget(
    BuildContext context, String s, TextEditingController textEditingController,
    {bool? isEnabled,
    var inputType,
    var inputFormatters,
    var onChanged,
    Widget? child}) {
  double radius = getDefaultRadius(context);
  double fontSize = getResizeFont(context, 40);
  Widget textFiled = TextFormField(
    maxLines: 6,
    onTap: () {},
    enabled: (isEnabled != null) ? isEnabled : true,
    controller: textEditingController,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    keyboardType: (inputType != null) ? inputType : null,
    inputFormatters: (inputFormatters != null) ? inputFormatters : null,
    onChanged: (onChanged != null) ? onChanged : null,
    style: TextStyle(
        fontFamily: Constants.fontsFamily,
        color: getFontColor(context),
        fontWeight: FontWeight.w400,
        fontSize: fontSize),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10.h, top: 2.h),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: s,
        isDense: true,
        hintStyle: TextStyle(
            fontFamily: Constants.fontsFamily,
            color: getSubFontColor(context),
            fontWeight: FontWeight.w400,
            fontSize: fontSize)),
  );

  return Container(
    alignment: Alignment.center,
    decoration: getDefaultDecoration(
        radius: radius,
        // bgColor: getReportColor(context),
        borderColor: getBorderColor(context),
        borderWidth: 1),
    padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
    child: child == null
        ? textFiled
        : Row(
            children: [Expanded(child: textFiled), child],
          ),
  );
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

Widget getDisableDropDownWidget(BuildContext context, String s,
    {bool? isEnabled,
    var inputType,
    var inputFormatters,
    var onChanged,
    Widget? child}) {
  double height = 45.h;

  if (Responsive.isTablet(context)) {
    height = 55.h;
  }

  double radius = getDefaultRadius(context);
  double fontSize = getResizeFont(context, 40);
  Widget textFiled = TextFormField(
    maxLines: 1,
    onTap: () {},
    enabled: false,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    keyboardType: (inputType != null) ? inputType : null,
    inputFormatters: (inputFormatters != null) ? inputFormatters : null,
    onChanged: (onChanged != null) ? onChanged : null,
    style: TextStyle(
        fontFamily: Constants.fontsFamily,
        color: getFontColor(context),
        fontWeight: FontWeight.w400,
        fontSize: fontSize),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 5.h, top: 2.h, right: 5.h),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: s,

        // suffixIcon: Container(alignment: Alignment.centerRight,child: imageAsset('down.png',
        //     height: 10.h, width: 10.h,color: getFontColor(context))),

        isDense: true,
        hintStyle: TextStyle(
            fontFamily: Constants.fontsFamily,
            color: getSubFontColor(context),
            fontWeight: FontWeight.w400,
            fontSize: fontSize)),
  );

  return Container(
    height: height,
    alignment: Alignment.center,
    decoration: getDefaultDecoration(
        radius: radius,
        bgColor: getCardColor(context),
        borderColor: getBorderColor(context),
        borderWidth: 1),
    child: Row(
      children: [
        Expanded(child: textFiled),
        imageAsset('down.png',
            height: 10.h, width: 10.h, color: getFontColor(context)),
        getHorizontalSpace(context, 5)
      ],
    ),
  );
}

Widget getDisableTextFiledWidget(BuildContext context, String s,
    {bool? isEnabled,
    var inputType,
    var inputFormatters,
    var onChanged,
    Widget? child}) {
  double height = 45.h;

  if (Responsive.isTablet(context)) {
    height = 55.h;
  }

  double radius = getDefaultRadius(context);
  double fontSize = getResizeFont(context, 40);
  Widget textFiled = TextFormField(
    maxLines: 1,
    onTap: () {},
    enabled: false,
    // enabled: (isEnabled != null) ? isEnabled : true,
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.top,
    keyboardType: (inputType != null) ? inputType : null,
    inputFormatters: (inputFormatters != null) ? inputFormatters : null,
    onChanged: (onChanged != null) ? onChanged : null,
    style: TextStyle(
        fontFamily: Constants.fontsFamily,
        color: getFontColor(context),
        fontWeight: FontWeight.w400,
        fontSize: fontSize),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 5.h, top: 2.h),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: s,
        isDense: false,
        // filled: true,
        // fillColor: getReportColor(context),
        hintStyle: TextStyle(
            fontFamily: Constants.fontsFamily,
            color: getSubFontColor(context),
            fontWeight: FontWeight.w400,
            fontSize: fontSize)),
  );

  return Container(
    height: height,
    alignment: Alignment.center,
    decoration: getDefaultDecoration(
        radius: radius,
        bgColor: getCardColor(context),
        borderColor: getBorderColor(context),
        borderWidth: 1),
    child: child == null
        ? textFiled
        : Row(
            children: [Expanded(child: textFiled), child],
          ),
  );
}

bool isNotEmpty(String s) {
  return (s.isNotEmpty);
}

Widget getSearchTextFiledWidget(
  BuildContext context,
  String s,
  TextEditingController textEditingController, {
  bool? isEnabled,
  var inputType,
  var inputFormatters,
  var onChanged,
}) {
  double height = 45.h;
  double radius = getResizeRadius(context, 45);
  double fontSize = getResizeFont(context, 45);

  return Container(
    height: height,
    alignment: Alignment.center,
    decoration:
        getDefaultDecoration(radius: radius, bgColor: getCardColor(context)
            // bgColor: getReportColor(context),
            ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20.h,
          alignment: Alignment.centerLeft,
          child: imageSvg('search.svg', height: 18.h, width: 18.h),
        ).marginSymmetric(horizontal: 15.h),
        Expanded(
          child: TextFormField(
            onTap: () {
              // if (onTapFunction != null) {
              //   onTapFunction();
              // }
            },
            enabled: (isEnabled != null) ? isEnabled : true,
            controller: textEditingController,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: (inputType != null) ? inputType : null,
            inputFormatters: (inputFormatters != null) ? inputFormatters : null,
            onChanged: (onChanged != null) ? onChanged : null,
            style: TextStyle(
                // height: 1.5,
                color: getFontColor(context),
                fontWeight: FontWeight.w400,
                fontFamily: Constants.fontsFamily,
                fontSize: fontSize),
            decoration: InputDecoration(
                // contentPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.only(top: (kIsWeb) ? 0.h : 0.h),
                // contentPadding: EdgeInsets.only(top: isWeb(context)?7.h:0.h,bottom:  isWeb(context)?0.h:10.h),
                border: InputBorder.none,
                // isCollapsed: true,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: s,
                // prefixIcon: Container(
                //   width: 20.h,
                //   alignment: Alignment.centerLeft,
                //   child: imageSvg('search.svg', height: 20.h, width: 20.h),
                // ).marginSymmetric(horizontal: 15.h),
                isDense: true,
                hintStyle: TextStyle(
                    color: getSubFontColor(context),
                    fontFamily: Constants.fontsFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize)),
          ),
        ),
      ],
    ),
  );
}

getResizeFont(BuildContext context, double font) {
  if (Responsive.isDesktop(context)) {
    return (font / 4).sp;
  } else if (Responsive.isTablet(context)) {
    return (font / 2).sp;
  } else {
    return (font / 1.2).sp;
  }
}

getResizeRadius(BuildContext context, double font) {
  if (Responsive.isDesktop(context)) {
    return (font / 2).r;
  } else if (Responsive.isTablet(context)) {
    return (font / 2).r;
  } else {
    return font.r;
  }
}

getResizeSize(BuildContext context, double size) {
  if (Responsive.isDesktop(context)) {
    return (size / 3.5);
  } else if (Responsive.isTablet(context)) {
    return (size / 2);
  } else {
    return size;
  }
}

getDefaultButtonSize(BuildContext context) {
  if (Responsive.isTablet(context)) {
    return 65.h;
  }

  return 55.h;
}

getDefaultRadius(BuildContext context) {
  if (Responsive.isDesktop(context)) {
    return 10.r;
  } else if (Responsive.isTablet(context)) {
    return 15.r;
  } else {
    return 25.r;
  }
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

getDefaultBtnRadius() {
  return 20.r;
}

getDefaultFontSize() {
  return 45.toDouble();
}

getDefaultPageSpace(BuildContext context) {
  if (Responsive.isDesktop(context)) {
    return 60.w;
  } else if (Responsive.isTablet(context)) {
    return 25.w;
  } else {
    return 15.w;
  }
}

getProgressDialog(BuildContext context,
    {Color? color, Color? backgroundColor, double? height, double? width}) {
  return new Container(
      height: height == null ? double.infinity : height,
      width: width == null ? double.infinity : width,
      child: new Center(
          child: CupertinoActivityIndicator(
        color: color == null ? Colors.grey : color,
      )));
}

getProgressWidget(BuildContext context) {
  return Center(
    child: Container(
      height: 70.h,
      width: 70.h,
      child: getProgressDialog(context, color: getPrimaryColor(context)),
    ),
  );
}

getHorizontalSpace(BuildContext context, double width) {
  if (Responsive.isDesktop(context)) {
    return width.w.horizontalSpace;
  } else if (Responsive.isTablet(context)) {
    return width.w.horizontalSpace;
  } else {
    return (width * 2).h.horizontalSpace;
  }
}

Widget getButtonWidget(BuildContext context, String s, Function function,
    {double? horizontalSpace,
    IconData? icon,
    var color,
    double? verticalSpace,
    Color? bgColor,
    bool? isProgress,
    Color? textColor,
    double? btnHeight,
    double? horPadding,
    double? verPadding,
    Widget? child,
    Color? iconColor}) {
  double height = btnHeight == null ? getDefaultButtonSize(context) : btnHeight;
  double radius = getDefaultRadius(context);
  double fontSize = btnHeight == null
      ? getDefaultFontSize()
      : getResizeFont(
          context, isWeb(context) ? (btnHeight * 3) : (btnHeight * 5.5));
  double progressDialogSize = isWeb(context) ? (15.h) : (5.h);

  return InkWell(
    onTap: (){},
    child: Container(
      height: height,
      margin: EdgeInsets.symmetric(
          vertical:
              verticalSpace == null ? getDefaultHorSpace(context) : verticalSpace,
          horizontal: horizontalSpace == null
              ? getDefaultHorSpace(context)
              : horizontalSpace),
      child: Material(
        // <----------------------------- Outer Material
        shadowColor: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        elevation: 0,
        child: Container(
          decoration: getDefaultDecoration(
            radius: radius,
            bgColor: bgColor == null ? primaryColor : bgColor,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: horPadding == null
                  ? 0
                  : isWeb(context)
                      ? horPadding
                      : (horPadding / 2),
              vertical: verPadding == null ? 0 : verPadding),
          child: Material(
            // <------------------------- Inner Material
            type: MaterialType.transparency,
            elevation: 1.0,
            color: Colors.transparent,
            shadowColor: Colors.black12,
            child: InkWell(
              //<------------------------- InkWell
              splashColor: Colors.black12,
              onTap: () {
                hideKeyboard();
                function();
              },
              child: Container(
                alignment: Alignment.center,
                child: (isProgress != null && isProgress)
                    ? getProgressDialog(context,
                        color: Colors.white,
                        backgroundColor: Colors.transparent,
                        width: progressDialogSize,
                        height: progressDialogSize)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          s.isEmpty
                              ? Container()
                              : getTextWidget(context, s, fontSize,
                                  textColor == null ? Colors.white : textColor,
                                  fontWeight: FontWeight.w600),
                          getHorizontalSpace(context, icon == null ? 0 : 15),
                          icon == null
                              ? Container()
                              : Container(
                                  child: Icon(
                                    icon,
                                    color: iconColor == null
                                        ? Colors.white
                                        : iconColor,
                                    size: 60.h,
                                  ),
                                ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget getPasswordTextFiledWidget(
  BuildContext context,
  String s,
  TextEditingController textEditingController, {
  bool? isEnabled,
  var inputType,
  var inputFormatters,
  var onChanged,
  var onSubmit,
}) {
  double height = getDefaultButtonSize(context);
  double radius = getDefaultRadius(context);
  double fontSize = getResizeFont(context, 45);

  RxBool isSecure = true.obs;

  return Container(
    height: height,
    alignment: Alignment.center,
    decoration: getDefaultDecoration(
        radius: radius,
        bgColor: getSubCardColor(context),
        borderColor: getBorderColor(context),
        borderWidth: 1),
    child: Obx(() => TextFormField(
      maxLines: 1,
      onTap: () {
        // if (onTapFunction != null) {
        //   onTapFunction();
        // }
      },
      onFieldSubmitted: (onSubmit != null) ? onSubmit : null,
      enabled: (isEnabled != null) ? isEnabled : true,
      controller: textEditingController,
      obscureText: isSecure.value,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: (inputType != null) ? inputType : null,
      inputFormatters: (inputFormatters != null) ? inputFormatters : null,
      onChanged: (onChanged != null) ? onChanged : null,
      style: TextStyle(
          color: getFontColor(context),
          fontFamily: Constants.fontsFamily,
          fontWeight: FontWeight.w400,
          fontSize: fontSize),
      decoration: InputDecoration(

          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: (){

                    (isSecure.value)?isSecure.value = false:isSecure.value = true;

                  },
                  child: Center(child: Obx(() => imageAsset((isSecure.value)?"hide.png":"view.png", height: 18.h, width: 18.h,color: Colors.grey.shade500)))),
            ],
          ),
          contentPadding: EdgeInsets.only(left: 22.w),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: s,
          isDense: false,
          hintStyle: TextStyle(
              fontFamily: Constants.fontsFamily,
              color: getSubFontColor(context),
              fontWeight: FontWeight.w400,
              fontSize: fontSize)),
    )),
  );
}

showCustomToast(
    {required BuildContext context, required String message, String? title}) {
  print("calledToast----true");
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: getResizeFont(context, 50));
}

getDefaultDecoration(
    {double? radius,
    Color? bgColor,
    Color? borderColor,
    bool? isShadow,
    Color? shadowColor,
    double? borderWidth,
    var shape}) {
  return ShapeDecoration(
    color: (bgColor == null) ? Colors.transparent : bgColor,
    shadows: isShadow == null
        ? []
        : [
            BoxShadow(
              color: Color(0x19acbfc1),
              blurRadius: 31,
              offset: Offset(0, 16),
            ),
          ],

    // [
    //         BoxShadow(
    //             color: shadowColor == null ? Colors.grey.shade200 : shadowColor,
    //             spreadRadius: 0,
    //             blurRadius: 10,
    //             offset: Offset(0, 3))
    //       ],
    shape: SmoothRectangleBorder(
      side: BorderSide(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: (borderWidth == null) ? 1 : borderWidth),
      borderRadius: SmoothBorderRadius(
        cornerRadius: (radius == null) ? 0 : radius,
        cornerSmoothing: 0.8,
      ),
    ),
  );
}

getCommonRadius(BuildContext context) {
  return getResizeRadius(context, 35);
}

getCommonPadding(BuildContext context) {
  if (Responsive.isDesktop(context)) {
    return 35.h;
  } else if (Responsive.isTablet(context)) {
    return 35.h;
  } else {
    return 15.h;
  }
}

isWeb(BuildContext context) {
  return Responsive.isDesktop(context);
}

getCommonContainer(
    {required BuildContext context,
    required Widget child,
    double? horSpace,
    double? verSpace,
    EdgeInsets? margin}) {
  double padding = horSpace == null ? getCommonPadding(context) : horSpace;
  double radius = getCommonRadius(context);

  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: verSpace == null ? getCommonPadding(context) : verSpace),
    margin: margin == null ? EdgeInsets.zero : margin,
    decoration: getDefaultDecoration(
        bgColor: getCardColor(context),
        isShadow: themeController.checkDarkTheme() ? null : true,
        radius: radius),
    child: child,
  );
}

getSideDecoration(
    {required double radius,
    bool? topRight,
    bool? topLeft,
    bool? bottomRight,
    bool? bottomLeft,
    Color? bgColor,
    Color? borderColor,
    bool? isShadow,
    Color? shadowColor,
    double? borderWidth,
    var shape}) {
  return ShapeDecoration(
    color: (bgColor == null) ? Colors.transparent : bgColor,
    shadows: isShadow == null
        ? []
        : [
            BoxShadow(
                color: shadowColor == null ? Colors.grey.shade200 : shadowColor,
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 3))
          ],
    shape: SmoothRectangleBorder(
      side: BorderSide(
          color: (borderColor == null) ? Colors.transparent : borderColor,
          width: (borderWidth == null) ? 1 : borderWidth),
      borderRadius: SmoothBorderRadius.only(
        topLeft: SmoothRadius(
          cornerRadius: topLeft == null ? 0 : radius,
          cornerSmoothing: 1,
        ),
        topRight: SmoothRadius(
          cornerRadius: topRight == null ? 0 : radius,
          cornerSmoothing: 1,
        ),
        bottomLeft: SmoothRadius(
          cornerRadius: bottomLeft == null ? 0 : radius,
          cornerSmoothing: 0.8,
        ),
        bottomRight: SmoothRadius(
          cornerRadius: bottomRight == null ? 0 : radius,
          cornerSmoothing: 0.8,
        ),
      ),
    ),
  );
}

getNoData(BuildContext context) {
  return getTextWidget(context, 'No data', 50, getFontColor(context),
      fontWeight: FontWeight.w500);
}

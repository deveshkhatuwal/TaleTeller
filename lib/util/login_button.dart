
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storyadminpanel/util/responsive.dart';

import '../theme/app_theme.dart';
import '../ui/common/common.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  final Function onChanged;
   String? title;
   BuildContext context;

  LoginButton({
    Key? key,
    required this.onChanged,
     this.title,
    required this.context
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Responsive(
      mobile:getReturnWidget(  _size.width < 650 ?45 : 65,) ,
      tablet:getReturnWidget(  55) ,
      desktop:getReturnWidget( _size.width < 1400 ?  45 : 55),
    );
  }

  getReturnWidget(double height) {
    return InkWell(
      onTap: () {
        onChanged();
      },
      child: Container(
          // margin: EdgeInsets.symmetric(
          //     vertical:  getPercentSize(height, 20) ),
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              color: primaryColor,
          ),

          child: Center(
              child:
              getTextWidget(context,title==null  ? 'Login': title!,35,Colors.white,fontWeight: FontWeight.w400),


          )
      ),
    );
  }
}

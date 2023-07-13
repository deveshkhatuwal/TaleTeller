import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/theme/app_theme.dart';
import 'package:storyadminpanel/ui/common/common.dart';

import '../../controller/data/key_table.dart';
import '../../main.dart';
import '../../model/app_detail_model.dart';
import '../../util/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Future.delayed(Duration(seconds: 3),() async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(KeyTable.adminData)
          .get();

      if(querySnapshot.docs.isEmpty){
        Get.toNamed(KeyUtil.adminPage);
      }else{
        Get.toNamed(isLogin?KeyUtil.homePage:KeyUtil.loginPage);
      }



    },);


  }

  @override
  Widget build(BuildContext context) {
    setScreenSize(context);
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(KeyTable.appDetail)
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.data != null && snapshot.data!.docs.isNotEmpty){

              List<DocumentSnapshot> list = snapshot.data!.docs;

              AppDetailModel model =
              AppDetailModel.fromFirestore(list[0]);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.h,
                        child: Image.network(model.image ?? "",height: double.infinity,width: double.infinity),
                        // alignment: Alignment.center,
                        // child: Center(child: imageSvg("book_active.svg", height: double.infinity, width: double.infinity,color: primaryColor)),
                      ),
                    ],
                  ),
                ],
              );
            }else{


              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.h,
                        alignment: Alignment.center,
                        child: Center(child: imageSvg("book_active.svg", height: double.infinity, width: double.infinity,color: primaryColor)),
                      ),
                    ],
                  ),
                ],
              );
            }
          }else{

            return Container();
          }
        // return Container();
      },),
    );
  }
}

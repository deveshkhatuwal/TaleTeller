import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/model/slider_model.dart';
import 'package:storyadminpanel/theme/app_theme.dart';

import '../../../controller/data/FirebaseData.dart';
import '../../../controller/data/key_table.dart';
import '../../../model/category_model.dart';
import '../../../model/story_model.dart';
import '../../../theme/color_scheme.dart';
import '../../common/common.dart';

class SliderWebScreen extends StatelessWidget{

  SliderWebScreen({required this.list,required this.queryText,required this.function,required this.onTapStatus});
  final List<DocumentSnapshot> list;
  final RxString queryText;
  final Function(SliderModel) function;
  final Function onTapStatus;


  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.symmetric(horizontal: 24.w,);

    return Expanded(
        child: Container(
          child: Column(
            children: [
              getHeaderWidget(
                  context),
              getVerticalSpace(context, 10),
              Expanded(
                  child: ListView
                      .builder(
                    // separatorBuilder: (context, index) {
                    //   SliderModel model =
                    //   SliderModel.fromFirestore(
                    //       list[index]);
                    //   return FutureBuilder<bool>(future:
                    //   FirebaseData.checkExist(model.storyId!, KeyTable.storyList),builder: (context, snapshot) {
                    //     if(snapshot.data != null && snapshot.data!){
                    //
                    //       return StreamBuilder<DocumentSnapshot?>(stream:
                    //       FirebaseFirestore.instance
                    //           .collection(KeyTable.storyList)
                    //           .doc(model.storyId!)
                    //           .snapshots(),
                    //           builder: (context, snapshot) {
                    //             if (snapshot.data != null &&
                    //                 snapshot.data!.exists) {
                    //               return separatorBuilder(
                    //                   context, queryText: queryText,
                    //                   value: StoryModel
                    //                       .fromFirestore(snapshot.data!)
                    //                       .name!);
                    //             } else {
                    //               return Container();
                    //             }
                    //           }
                    //
                    //
                    //       );
                    //
                    //     }
                    //
                    //
                    //     return Container();
                    //   },);
                    //
                    // },
                    itemCount:
                    list
                        .length,
                    itemBuilder:
                        (context, index) {
                          SliderModel
                      model =
                      SliderModel.fromFirestore(
                          list[
                          index]);


                          return StreamBuilder<DocumentSnapshot>(stream:
                          FirebaseFirestore.instance
                              .collection(KeyTable.storyList)
                              .doc(model.storyId!)
                              .snapshots(),

                            builder: (context, snapshot) {

                              if(snapshot.data != null ) {

                                if(snapshot.data!.exists){


                                  StoryModel storyModel = StoryModel.fromFirestore(snapshot.data!);


                                  return FutureBuilder<bool>(future: FirebaseData.checkCategoryExists(
                                      storyModel.refId!),builder: (context, snapshot) {
                                    if (snapshot.data != null && snapshot.data!) {
                                      return Obx(() {
                                        bool cell = true;

                                        if (queryText.value.isNotEmpty &&
                                            !storyModel.name!.contains(
                                                queryText.value)) {
                                          cell = false;
                                        }

                                        return cell
                                            ?
                                        Container(

                                          height: 88.h,
                                          decoration: getDefaultDecoration(
                                            bgColor: getReportColor(context),
                                            radius: getResizeRadius(context, 12),
                                          ),
                                          padding: padding,
                                          margin: EdgeInsets.symmetric(vertical: 8.h),
                                          child:
                                          Row(
                                            children: [
                                              getHeaderCell(
                                                  '${index + 1}', context, 80),
                                              getHeaderCell(
                                                  '${storyModel.date}', context,
                                                  150),
                                              Expanded(
                                                  child: StreamBuilder<
                                                      DocumentSnapshot>(
                                                    stream:
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                        KeyTable.categoryList)
                                                        .doc(storyModel.refId!)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      return snapshot.data == null
                                                          ? Container()
                                                          : Container(
                                                        child: getMaxLineFont(
                                                            context, CategoryModel
                                                            .fromFirestore(
                                                            snapshot.data!)
                                                            .name!, 50  ,
                                                            getFontColor(context),
                                                            1,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            textAlign: TextAlign
                                                                .start),
                                                      );
                                                    },
                                                  )),
                                              Expanded(
                                                  child: getHeaderTitle(context,
                                                      '${storyModel.name!}')),
                                              getHeaderCell(
                                                  '${storyModel.views}', context,
                                                  150),
                                              Container(
                                                width: 150.h,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 115.h,
                                                      child: getActiveDeActiveCell(
                                                          context, storyModel.isActive!,
                                                          storyModel),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  getMaxLineFont(
                                                      context, 'Action', 50,
                                                      Colors.transparent, 1,
                                                      fontWeight: FontWeight.w600,
                                                      textAlign: TextAlign.start),
                                                  Positioned.fill(
                                                      child: Center(
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              function(model);
                                                            },
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: getSubFontColor(
                                                                  context),
                                                            )),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                            : Container();
                                      });
                                    }

                                    return Container();
                                  },);



                                }else{
                                  return Container();
                                }


                              }else{
                                return Container();
                              }
                            },);


                          // return FutureBuilder<bool>(future: FirebaseData.checkExist(model.storyId!,
                          //     KeyTable.storyList),builder: (context, snapshot) {
                          //
                          //   print("snapshot----${snapshot.data}");
                          //
                          //   if(snapshot.data != null && snapshot.data!){
                          //
                          //     return StreamBuilder<DocumentSnapshot?>(stream:
                          //       FirebaseFirestore.instance
                          //           .collection(KeyTable.storyList)
                          //           .doc(model.storyId!)
                          //           .snapshots(),
                          //
                          //         builder: (context, snapshot) {
                          //
                          //           if(snapshot.data != null ) {
                          //
                          //             StoryModel storyModel = StoryModel.fromFirestore(snapshot.data!);
                          //             return FutureBuilder<bool>(future: FirebaseData.checkCategoryExists(
                          //                 storyModel.refId!),builder: (context, snapshot) {
                          //               if (snapshot.data != null && snapshot.data!) {
                          //                 return Obx(() {
                          //                   bool cell = true;
                          //
                          //                   if (queryText.value.isNotEmpty &&
                          //                       !storyModel.name!.contains(
                          //                           queryText.value)) {
                          //                     cell = false;
                          //                   }
                          //
                          //                   return cell
                          //                       ?
                          //                   Container(
                          //
                          //                     height: 88.h,
                          //                     decoration: getDefaultDecoration(
                          //                       bgColor: getReportColor(context),
                          //                       radius: getResizeRadius(context, 12),
                          //                     ),
                          //                     padding: padding,
                          //                     margin: EdgeInsets.symmetric(vertical: 8.h),
                          //                     child:
                          //                     Row(
                          //                       children: [
                          //                         getHeaderCell(
                          //                             '${index + 1}', context, 80),
                          //                         getHeaderCell(
                          //                             '${storyModel.date}', context,
                          //                             150),
                          //                         Expanded(
                          //                             child: StreamBuilder<
                          //                                 DocumentSnapshot>(
                          //                               stream:
                          //                               FirebaseFirestore.instance
                          //                                   .collection(
                          //                                   KeyTable.categoryList)
                          //                                   .doc(storyModel.refId!)
                          //                                   .snapshots(),
                          //                               builder:
                          //                                   (context, snapshot) {
                          //                                 return snapshot.data == null
                          //                                     ? Container()
                          //                                     : Container(
                          //                                   child: getMaxLineFont(
                          //                                       context, CategoryModel
                          //                                       .fromFirestore(
                          //                                       snapshot.data!)
                          //                                       .name!, 50  ,
                          //                                       getFontColor(context),
                          //                                       1,
                          //                                       fontWeight: FontWeight
                          //                                           .w500,
                          //                                       textAlign: TextAlign
                          //                                           .start),
                          //                                 );
                          //                               },
                          //                             )),
                          //                         Expanded(
                          //                             child: getHeaderTitle(context,
                          //                                 '${storyModel.name!}')),
                          //                         getHeaderCell(
                          //                             '${storyModel.views}', context,
                          //                             100),
                          //                         Container(
                          //                           width: 115.h,
                          //                           child: getActiveDeActiveCell(
                          //                               context, storyModel.isActive!,
                          //                               storyModel),
                          //                         ),
                          //                         Stack(
                          //                           children: [
                          //                             getMaxLineFont(
                          //                                 context, 'Action', 50,
                          //                                 Colors.transparent, 1,
                          //                                 fontWeight: FontWeight.w600,
                          //                                 textAlign: TextAlign.start),
                          //                             Positioned.fill(
                          //                                 child: Center(
                          //                                   child: GestureDetector(
                          //                                       onTap: () {
                          //                                         function(model);
                          //                                       },
                          //                                       child: Icon(
                          //                                         Icons.delete,
                          //                                         color: getSubFontColor(
                          //                                             context),
                          //                                       )),
                          //                                 ))
                          //                           ],
                          //                         )
                          //                       ],
                          //                     ),
                          //                   )
                          //                       : Container();
                          //                 });
                          //               }
                          //
                          //               return Container();
                          //             },);
                          //           }else{
                          //             return Container();
                          //           }
                          //         },);
                          //
                          //   }
                          //
                          //
                          //   return Container();
                          // },);

                    },
                  ))
            ],
          ),
        ));
  }


  getActiveDeActiveCell(BuildContext context, bool isActive,StoryModel storyModel) {
    return InkWell(
      child: Container(
          width: 120.h,
          alignment: Alignment.centerLeft,
          child: getButton(
              context,
              isActive ? 'Active' : 'Deactive',
              isActive ? "#00A010".toColor() : "#FD3E3E".toColor(),
              isActive ? "#E7FFE8".toColor() : "#FFF2F2".toColor())),
      onTap: (){
        onTapStatus(storyModel);
      },
    );
  }

  getButton(BuildContext context, String string, Color color, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 15.h),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(getResizeRadius(context, 45)),
          border: Border.all(color: color)
      ),
      child: getMaxLineFont(context, string, 45, color, 1,
          fontWeight: FontWeight.w400, textAlign: TextAlign.start),
    );
  }
  getHeaderWidget(BuildContext context) {
    var padding = EdgeInsets.symmetric(horizontal: 24.w,);
    var decoration =
    getDefaultDecoration(radius: 0);
    return Container(
      padding: padding,
      decoration: decoration,
      child: Row(
        children: [
          getHeaderCell('Id', context, 80),
          getHeaderCell('Date', context, 150),
          Expanded(child: getHeaderTitle(context, 'Category')),
          Expanded(child: getHeaderTitle(context, 'Story Title')),
          getHeaderCell(
              'Views'
                  '',
              context,
              150),
          getHeaderCell(
              'Story Status'
                  '',
              context,
              150),
          getHeaderTitle(context, 'Action'),
        ],
      ),
    );
  }
  getHeaderCell(String title, BuildContext context, double width) {
    return Container(
        width: width.h,
        alignment: Alignment.centerLeft,
        child: getHeaderTitle(context, title));
  }


  getHeaderTitle(BuildContext context, String title) {
    return getMaxLineFont(context, title, 45, getFontColor(context), 1,
        fontWeight: FontWeight.w600, textAlign: TextAlign.start);
  }
}
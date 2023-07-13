import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/theme/app_theme.dart';

import '../../../controller/data/key_table.dart';
import '../../../model/story_model.dart';
import '../../../theme/color_scheme.dart';
import '../../common/common.dart';

// ignore: must_be_immutable
class MobileWidget extends StatelessWidget{

  var _tapPosition;
  MobileWidget({required this.list,required this.queryText,required this.function,required this.onTapStatus,required this.mainList});
  final List<DocumentSnapshot> list;
  final List<DocumentSnapshot> mainList;
  final RxString queryText;
  final Function(Offset,StoryModel) function;
  final Function onTapStatus;


  @override
  Widget build(BuildContext context) {


    return Expanded(
      child: ListView(
        children: [
          SingleChildScrollView(
              scrollDirection:
              Axis.horizontal,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  getHeaderWidget(
                      context),

                  Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: List.generate(
                          list.length,
                              (index) {

                            StoryModel storyModel = StoryModel.fromFirestore(list[index]);

                            bool cell = true;

                            return StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance.collection(KeyTable.categoryList).doc(storyModel.refId).snapshots(),
                              builder: (context, snapshot) {
                              if (snapshot.data != null ) {

                                if(snapshot.data!.exists){
                                  return Obx(
                                            () {
                                          if (queryText.value.isNotEmpty &&
                                              !storyModel.name!.contains(queryText.value)) {
                                            cell =
                                            false;
                                          }

                                          return cell
                                              ? Stack(
                                            children: [
                                              Container(

                                                height: 100.h,
                                                decoration: getDefaultDecoration(
                                                  bgColor: getReportColor(context),
                                                  radius: getResizeRadius(context, 12),
                                                ),
                                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 4.h),
                                                child: Row(
                                                  children: [
                                                    getSubCell(
                                                        '${storyModel.index}',
                                                        // '${mainList.indexOf(list[index]) + 1}',
                                                        // '${index + 1}',
                                                        context, 80),
                                                    getSubCell('${storyModel.date}', context, 100),

                                                    // Container(
                                                    //   width: 100.h,
                                                    //    child: Row(
                                                    //      children: [
                                                    //        Container(
                                                    //         height: 50.h,
                                                    //         width: 75.h,
                                                    //         alignment: Alignment.centerLeft,
                                                    //         child: ClipRRect(
                                                    //           borderRadius: BorderRadius.circular(10.r),
                                                    //           child: Image(
                                                    //             image: NetworkImage(storyModel.image ?? ""),
                                                    //           ),
                                                    //         ),
                                                    //   ),
                                                    //        Expanded(child: Container())
                                                    //      ],
                                                    //    ),
                                                    //
                                                    // ),

                                                    Container(
                                                    width: 150.h,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: double.infinity,
                                                          width: 125.h,
                                                          decoration: BoxDecoration(
                                                              image: getDecorationNetworkImage(context, storyModel.image ?? "",
                                                                  fit: BoxFit.cover),
                                                              borderRadius: BorderRadius.all(Radius.circular(12.h))),
                                                        ),
                                                        Spacer()
                                                      ],
                                                    ),
                                                    ),
                                                    // Container(
                                                    //   width: 250.h,
                                                    //   child: StreamBuilder<DocumentSnapshot>(
                                                    //     stream: FirebaseFirestore.instance.collection(KeyTable.categoryList).doc(storyModel.refId!).snapshots(),
                                                    //     builder: (context, snapshot) {
                                                    //       return snapshot.data == null
                                                    //           ? Container()
                                                    //           : Row(
                                                    //         children: [
                                                    //
                                                    //
                                                    //
                                                    //
                                                    //
                                                    //           // getHorizontalSpace(context, 10),
                                                    //           Expanded(child: getMaxLineFont(context, CategoryModel.fromFirestore(snapshot.data!).name!, 50, getFontColor(context), 1, fontWeight: FontWeight.w500, textAlign: TextAlign.start)),
                                                    //         ],
                                                    //       );
                                                    //     },
                                                    //   ),
                                                    // ),

                                                    getSubCell('${storyModel.name}', context, 200),
                                                    getSubCell('${storyModel.views}', context, 100),
                                                    getActiveDeActiveCell(context, false,storyModel),
                                                    // getActiveDeActiveCell( context, storyModel.isActive!),

                                                    Container(
                                                      width: 80.h,
                                                      alignment: Alignment.centerLeft,
                                                      child: GestureDetector(
                                                          onTapDown: _storePosition,
                                                          onTap: () {

                                                            function(_tapPosition,storyModel);
                                                          },
                                                          child: Icon(
                                                            Icons.more_vert,
                                                            color: getSubFontColor(context),
                                                            size: 25.h,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              // Positioned.fill(child: Align(alignment: Alignment.bottomLeft,
                                              //   child: Divider(
                                              //     height: 0.5,
                                              //     color: cell?getBorderColor(context):Colors.transparent,
                                              //   ).marginSymmetric(vertical: 4.h),))
                                            ],
                                          )
                                              : Container();
                                        });
                                }else{
                                  return Container();
                                }

                              }
                              return Container();
                            },);


                            // return FutureBuilder<bool>(future: FirebaseData.checkCategoryExists(
                            //       storyModel.refId!),builder: (context, snapshot) {
                            //     if (snapshot.data != null && snapshot.data!) {
                            //       return
                            //         Obx(
                            //                 () {
                            //               if (queryText.value.isNotEmpty &&
                            //                   !storyModel.name!.contains(queryText.value)) {
                            //                 cell =
                            //                 false;
                            //               }
                            //
                            //               return cell
                            //                   ? Stack(
                            //                 children: [
                            //                   Container(
                            //
                            //                     height: 88.h,
                            //                     decoration: getDefaultDecoration(
                            //                       bgColor: getReportColor(context),
                            //                       radius: getResizeRadius(context, 12),
                            //                     ),
                            //                     margin: EdgeInsets.symmetric(vertical: 8.h),
                            //                     padding: EdgeInsets.symmetric(horizontal: 15.w,),
                            //                     child: Row(
                            //                       children: [
                            //                         getSubCell('${index + 1}', context, 80),
                            //                         getSubCell('${storyModel.date}', context, 100),
                            //
                            //                         // Container(
                            //                         //   width: 100.h,
                            //                         //    child: Row(
                            //                         //      children: [
                            //                         //        Container(
                            //                         //         height: 50.h,
                            //                         //         width: 75.h,
                            //                         //         alignment: Alignment.centerLeft,
                            //                         //         child: ClipRRect(
                            //                         //           borderRadius: BorderRadius.circular(10.r),
                            //                         //           child: Image(
                            //                         //             image: NetworkImage(storyModel.image ?? ""),
                            //                         //           ),
                            //                         //         ),
                            //                         //   ),
                            //                         //        Expanded(child: Container())
                            //                         //      ],
                            //                         //    ),
                            //                         //
                            //                         // ),
                            //
                            //                         Container(
                            //                           width: 250.h,
                            //                           child: StreamBuilder<DocumentSnapshot>(
                            //                             stream: FirebaseFirestore.instance.collection(KeyTable.categoryList).doc(storyModel.refId!).snapshots(),
                            //                             builder: (context, snapshot) {
                            //                               return snapshot.data == null
                            //                                   ? Container()
                            //                                   : Row(
                            //                                 children: [
                            //
                            //
                            //
                            //                                   Container(
                            //                                     width: 120.h,
                            //                                     child: ClipRRect(
                            //                                       borderRadius: BorderRadius
                            //                                           .circular(10.r),
                            //                                       child: Image(
                            //                                         image: NetworkImage(
                            //                                             CategoryModel
                            //                                                 .fromFirestore(snapshot
                            //                                                 .data!)
                            //                                                 .image!),fit: BoxFit.fill,height: double.infinity,width: double.infinity,
                            //                                       ),
                            //                                     ),
                            //                                   ),
                            //
                            //                                   getHorizontalSpace(context, 10),
                            //                                   Expanded(child: getMaxLineFont(context, CategoryModel.fromFirestore(snapshot.data!).name!, 50, getFontColor(context), 1, fontWeight: FontWeight.w500, textAlign: TextAlign.start)),
                            //                                 ],
                            //                               );
                            //                             },
                            //                           ),
                            //                         ),
                            //
                            //                         getSubCell('${storyModel.name}', context, 200),
                            //                         getSubCell('${storyModel.views}', context, 100),
                            //                         getActiveDeActiveCell(context, false,storyModel),
                            //                         // getActiveDeActiveCell( context, storyModel.isActive!),
                            //
                            //                         Container(
                            //                           width: 80.h,
                            //                           alignment: Alignment.centerLeft,
                            //                           child: GestureDetector(
                            //                               onTapDown: _storePosition,
                            //                               onTap: () {
                            //
                            //                                 function(_tapPosition,storyModel);
                            //                               },
                            //                               child: Icon(
                            //                                 Icons.more_vert,
                            //                                 color: getSubFontColor(context),
                            //                                 size: 25.h,
                            //                               )),
                            //                         )
                            //                       ],
                            //                     ),
                            //                   ),
                            //                   // Positioned.fill(child: Align(alignment: Alignment.bottomLeft,
                            //                   //   child: Divider(
                            //                   //     height: 0.5,
                            //                   //     color: cell?getBorderColor(context):Colors.transparent,
                            //                   //   ).marginSymmetric(vertical: 4.h),))
                            //                 ],
                            //               )
                            //                   : Container();
                            //             });
                            //     }
                            //     return Container();
                            //   },);
                          }))
                ],
              ))
        ],
      ),
    );
  }
  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }


  getSubCell(String title, BuildContext context, double width) {
    return Container(
        width: width.h,
        alignment: Alignment.centerLeft,
        child: getSubTitle(context, title));
  }
  getActiveDeActiveCell(BuildContext context, bool isActive,StoryModel model) {
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
        onTapStatus(model);
      },
    );
  }


  getSubTitle(BuildContext context, String title) {
    return getMaxLineFont(context, title, 45, getFontColor(context), 1,
        fontWeight: FontWeight.w400, textAlign: TextAlign.start);
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
    var decoration =
    getDefaultDecoration(radius: 0);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      decoration: decoration,
      height: 55.h,
      child: Row(
        // scrollDirection: Axis.horizontal,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          getHeaderCell('Id', context, 80),
          getHeaderCell('Date', context, 100),
          getHeaderCell('Image', context, 150),
          // getHeaderCell('Category', context, 250),
          getHeaderCell('Story Title', context, 200),
          getHeaderCell('Views', context, 100),
          getHeaderCell('Story Status', context, 120),
          getHeaderCell('Action', context, 80),
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
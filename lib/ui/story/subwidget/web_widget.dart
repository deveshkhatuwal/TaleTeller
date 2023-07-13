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
class WebWidget extends StatelessWidget{

  var _tapPosition;
  WebWidget({required this.list,required this.queryText,required this.function,required this.onTapStatus,required this.mainList});
  final List<DocumentSnapshot> list;
  final List<DocumentSnapshot> mainList;
  final RxString queryText;
  final Function(Offset,StoryModel) function;
  final Function onTapStatus;


  @override
  Widget build(BuildContext context) {
    var padding = EdgeInsets.symmetric(horizontal: 24.w,vertical: 4.h);

    return Expanded(
        child: Container(
          child: Column(
            children: [
              getHeaderWidget(
                  context),

              getVerticalSpace(context, 20),
              Expanded(
                  child: ListView
                      .builder(
                    // separatorBuilder: (context, index) {
                    //   StoryModel model =
                    //   StoryModel.fromFirestore(
                    //       list[index]);
                    //   return FutureBuilder<bool>(
                    //     future: FirebaseData.checkCategoryExists(model.refId!),
                    //     builder: (context, snapshot) {
                    //     if (snapshot.data != null && snapshot.data!) {
                    //       return separatorBuilder(
                    //           context, queryText: queryText, value: model
                    //           .name!);
                    //     }
                    //
                    //     return Container();
                    //   },);
                    // },
                    itemCount:
                    list
                        .length,
                    itemBuilder:
                        (context, index) {
                      StoryModel
                      storyModel =
                      StoryModel.fromFirestore(
                          list[
                          index]);


                      return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection(KeyTable.categoryList).doc(storyModel.refId).snapshots(),
                        builder: (context, snapshot) {
                        if (snapshot.data != null) {

                          if(snapshot.data!.exists){
                            return Obx(() {
                              bool cell = true;

                              if (queryText
                                  .value
                                  .isNotEmpty &&
                                  !storyModel
                                      .name!
                                      .contains(
                                      queryText
                                          .value)) {
                                cell = false;
                              }
                              return cell
                                  ? Container(
                                height: 100.h,
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
                                        '${storyModel.index}',
                                        // '${mainList.indexOf(list[index]) + 1}',
                                        // '${index + 1}',
                                        context,
                                        80),

                                    getHeaderCell(
                                        '${storyModel.date}',
                                        context,
                                        130),


                                    Container(
                                      width: 250.h,
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

                                      // Container(
                                      //   height: double.infinity,
                                      //   width: 125.h,
                                      //
                                      //
                                      //   decoration: BoxDecoration(
                                      //     // image: getDecorationNetworkImage(context, storyModel.image ?? "",
                                      //     //     fit: BoxFit.cover),
                                      //       borderRadius: BorderRadius.all(Radius.circular(10.h))),
                                      //
                                      //   child: getShimmerWidget(context, Container(height: double.infinity,width: double.infinity,)),
                                      // ),
                                    ),

                                    // Expanded(
                                    //     flex: 2,
                                    //     child: StreamBuilder<DocumentSnapshot>(
                                    //       stream:
                                    //       FirebaseFirestore.instance.collection(
                                    //           KeyTable.categoryList).doc(
                                    //           storyModel.refId!).snapshots(),
                                    //       builder:
                                    //           (context, snapshot) {
                                    //         return snapshot.data == null
                                    //             ? Container(
                                    //           child: Row(
                                    //             children: [
                                    //
                                    //
                                    //
                                    //
                                    //
                                    //               // ClipRRect(
                                    //               //     borderRadius: BorderRadius
                                    //               //         .circular(5.r),
                                    //               //     child: getShimmerWidget(context, Container(
                                    //               //       color: Colors.grey,
                                    //               //       height: double.infinity,width: 129.h,
                                    //               //     ))
                                    //
                                    //                 // Image(
                                    //                 //   image: NetworkImage(
                                    //                 //       CategoryModel
                                    //                 //           .fromFirestore(snapshot
                                    //                 //           .data!)
                                    //                 //           .image!),fit: BoxFit.fill,height: double.infinity,width: 129.h,
                                    //                 // ),
                                    //               // ),
                                    //
                                    //
                                    //               // getHorizontalSpace(
                                    //               //   context,
                                    //               //   10,
                                    //               // ),
                                    //
                                    //
                                    //               getShimmerWidget(context, Container(
                                    //
                                    //                 color: Colors.grey,
                                    //                 child: getMaxLineFont(
                                    //                     context, "zxccfbxcfxcfgxfg",
                                    //                     50, getFontColor(context),
                                    //                     1,
                                    //                     fontWeight: FontWeight.w400,
                                    //                     textAlign: TextAlign
                                    //                         .start),
                                    //               )),
                                    //             ],
                                    //           ),
                                    //         )
                                    //             : Container(
                                    //           child: Row(
                                    //             children: [
                                    //
                                    //
                                    //
                                    //
                                    //
                                    //
                                    //               // ClipRRect(
                                    //               //   borderRadius: BorderRadius
                                    //               //       .circular(5.r),
                                    //               //   child: Image(
                                    //               //     image: NetworkImage(
                                    //               //         storyModel.image ?? "",fit: BoxFit.fill,height: double.infinity,width: 129.h,
                                    //               //   ),
                                    //               // ),),
                                    //
                                    //
                                    //               // getHorizontalSpace(
                                    //               //   context,
                                    //               //   10,
                                    //               // ),
                                    //
                                    //
                                    //               getMaxLineFont(
                                    //                   context, CategoryModel
                                    //                   .fromFirestore(snapshot
                                    //                   .data!)
                                    //                   .name!,
                                    //                   50, getFontColor(context),
                                    //                   1,
                                    //                   fontWeight: FontWeight.w400,
                                    //                   textAlign: TextAlign
                                    //                       .start),
                                    //
                                    //             ],
                                    //           ),
                                    //         );
                                    //       },
                                    //     )),
                                    Expanded(
                                        flex: 1,
                                        child: getHeaderTitle(
                                            context, '${storyModel.name!}')),
                                    getHeaderCell(
                                        '${storyModel.views}'
                                            '',
                                        context,
                                        150),
                                    getActiveDeActiveCell(
                                        context,
                                        storyModel.isActive!, storyModel),
                                    Stack(
                                      children: [
                                        getMaxLineFont(context, 'Action', 50,
                                            Colors.transparent, 1,
                                            fontWeight: FontWeight.w600,
                                            textAlign: TextAlign.start),
                                        Positioned.fill(
                                            child: Center(
                                              child: GestureDetector(
                                                  onTapDown: _storePosition,
                                                  onTap: () {
                                                    function(
                                                        _tapPosition, storyModel);
                                                  },
                                                  child: Icon(
                                                    Icons.more_vert,
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
                          }else{
                            return Container();
                          }

                        }
                        return Container();
                      },);

                      // return FutureBuilder<bool>(future: FirebaseData.checkCategoryExists(
                      //     storyModel.refId!),builder: (context, snapshot) {
                      //   if (snapshot.data != null && snapshot.data!) {
                      //     return Obx(() {
                      //       bool cell = true;
                      //
                      //       if (queryText
                      //           .value
                      //           .isNotEmpty &&
                      //           !storyModel
                      //               .name!
                      //               .contains(
                      //               queryText
                      //                   .value)) {
                      //         cell = false;
                      //       }
                      //       return cell
                      //           ? Container(
                      //         height: 88.h,
                      //         decoration: getDefaultDecoration(
                      //           bgColor: getReportColor(context),
                      //           radius: getResizeRadius(context, 12),
                      //         ),
                      //         padding: padding,
                      //         margin: EdgeInsets.symmetric(vertical: 8.h),
                      //         child:
                      //         Row(
                      //           children: [
                      //             getHeaderCell(
                      //                 '${index + 1}',
                      //                 context,
                      //                 80),
                      //             getHeaderCell(
                      //                 '${storyModel.date}',
                      //                 context,
                      //                 130),
                      //
                      //             Expanded(
                      //               flex: 2,
                      //                 child: StreamBuilder<DocumentSnapshot>(
                      //                   stream:
                      //                   FirebaseFirestore.instance.collection(
                      //                       KeyTable.categoryList).doc(
                      //                       storyModel.refId!).snapshots(),
                      //                   builder:
                      //                       (context, snapshot) {
                      //                     return snapshot.data == null
                      //                         ? Container(
                      //                       child: Row(
                      //                         children: [
                      //
                      //
                      //
                      //                           ClipRRect(
                      //                             borderRadius: BorderRadius
                      //                                 .circular(5.r),
                      //                             child: getShimmerWidget(context, Container(
                      //                               color: Colors.grey,
                      //                               height: double.infinity,width: 129.h,
                      //                             ))
                      //
                      //                             // Image(
                      //                             //   image: NetworkImage(
                      //                             //       CategoryModel
                      //                             //           .fromFirestore(snapshot
                      //                             //           .data!)
                      //                             //           .image!),fit: BoxFit.fill,height: double.infinity,width: 129.h,
                      //                             // ),
                      //                           ),
                      //
                      //
                      //                           getHorizontalSpace(
                      //                             context,
                      //                             10,
                      //                           ),
                      //
                      //
                      //                           getShimmerWidget(context, Container(
                      //
                      //                             color: Colors.grey,
                      //                             child: getMaxLineFont(
                      //                                 context, "zxccfbxcfxcfgxfg",
                      //                                 50, getFontColor(context),
                      //                                 1,
                      //                                 fontWeight: FontWeight.w400,
                      //                                 textAlign: TextAlign
                      //                                     .start),
                      //                           )),
                      //                         ],
                      //                       ),
                      //                     )
                      //                         : Container(
                      //                       child: Row(
                      //                         children: [
                      //
                      //
                      //
                      //                           ClipRRect(
                      //                             borderRadius: BorderRadius
                      //                                 .circular(5.r),
                      //                             child: Image(
                      //                               image: NetworkImage(
                      //                                   CategoryModel
                      //                                       .fromFirestore(snapshot
                      //                                       .data!)
                      //                                       .image!),fit: BoxFit.fill,height: double.infinity,width: 129.h,
                      //                             ),
                      //                           ),
                      //
                      //
                      //                           getHorizontalSpace(
                      //                             context,
                      //                             10,
                      //                           ),
                      //
                      //
                      //                           getMaxLineFont(
                      //                               context, CategoryModel
                      //                               .fromFirestore(snapshot
                      //                               .data!)
                      //                               .name!,
                      //                               50, getFontColor(context),
                      //                               1,
                      //                               fontWeight: FontWeight.w400,
                      //                               textAlign: TextAlign
                      //                                   .start),
                      //
                      //                         ],
                      //                       ),
                      //                     );
                      //                   },
                      //                 )),
                      //             Expanded(
                      //               flex: 2,
                      //                 child: getHeaderTitle(
                      //                     context, '${storyModel.name!}')),
                      //             getHeaderCell(
                      //                 '${storyModel.views}'
                      //                     '',
                      //                 context,
                      //                 100),
                      //             getActiveDeActiveCell(
                      //                 context,
                      //                 storyModel.isActive!, storyModel),
                      //             Stack(
                      //               children: [
                      //                 getMaxLineFont(context, 'Action', 50,
                      //                     Colors.transparent, 1,
                      //                     fontWeight: FontWeight.w600,
                      //                     textAlign: TextAlign.start),
                      //                 Positioned.fill(
                      //                     child: Center(
                      //                       child: GestureDetector(
                      //                           onTapDown: _storePosition,
                      //                           onTap: () {
                      //                             function(
                      //                                 _tapPosition, storyModel);
                      //                           },
                      //                           child: Icon(
                      //                             Icons.more_vert,
                      //                             color: getSubFontColor(
                      //                                 context),
                      //                           )),
                      //                     ))
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       )
                      //           : Container();
                      //     });
                      //   }
                      //   return Container();
                      // },);
                    },
                  ))
            ],
          ),
        ));
  }
  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
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
      child: getMaxLineFont(context, string, 40, color, 1,
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
          getHeaderCell('Id', context, 80,fontWeight: FontWeight.w600),
          getHeaderCell('Date', context, 130,fontWeight: FontWeight.w600),
          getHeaderCell("Image", context, 250,fontWeight: FontWeight.w600),
          // Expanded(flex: 1,child: getHeaderTitle(context, 'image')),
          // Expanded(flex: 2,child: getHeaderTitle(context, 'Category',fontWeight: FontWeight.w600)),
          Expanded(flex: 2,child: getHeaderTitle(context, 'Story Title',fontWeight: FontWeight.w600)),
          getHeaderCell(
              'Views'
                  '',
              context,
              150,fontWeight: FontWeight.w600),
          getHeaderCell(
              'Story Status'
                  '',
              context,
              120,fontWeight: FontWeight.w600),
          getHeaderTitle(context, 'Action',fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
  getHeaderCell(String title, BuildContext context, double width,
      {FontWeight fontWeight = FontWeight.w400}) {
    return Container(
        width: width.h,
        alignment: Alignment.centerLeft,
        child: getHeaderTitle(context, title,fontWeight: fontWeight));
  }



  getHeaderTitle(BuildContext context, String title, {FontWeight fontWeight = FontWeight.w400}) {
    return getMaxLineFont(context, title, 45, getFontColor(context), 1,
        fontWeight: fontWeight, textAlign: TextAlign.start);
  }


}
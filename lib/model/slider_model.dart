import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/data/key_table.dart';

class SliderModel{


  
  String? id="";
  String? storyId="";
  int? index=1;

  
  
  SliderModel({this.id,this.storyId,this.index,});

  factory SliderModel.fromFirestore(DocumentSnapshot doc) {


    Map data = doc.data() as Map;


    return SliderModel(
      id: doc.id,
      storyId: data[KeyTable.storyId] ??'',
      index: data['index']??0,

      
    );
  }

  factory SliderModel.fromJson(Map<String, dynamic> data) {



    return SliderModel(
      storyId: data[KeyTable.storyId],
      index: data['index'],    );


  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[KeyTable.storyId] = this.storyId;
    data['index'] = this.index;
    return data;
  }


}
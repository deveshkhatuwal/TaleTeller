


import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String? username;
  String? deviceId;
  String? image;
  String? id;


  AdminModel({this.deviceId,this.username,this.image,this.id, });

  factory AdminModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    print("dat===$data");

    return AdminModel(

        username: (data['username']==null)?"":data['username'],
      deviceId: (data['device_id']==null)?"":data['device_id'],
      id:doc.id,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_id'] = this.deviceId;
    return data;
  }


}

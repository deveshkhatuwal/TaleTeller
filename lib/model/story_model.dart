import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel{

  String? name="";
  String? image="";
  String? audio="";
  String? desc="";
  String? date="";
  String? id="";
  String? storyId="";
  String? refId='';
  int? index=1;
  int? views=1;
  bool? isBookmark=false;
  bool? isFav=false;
  bool? isActive=true;

  StoryModel({this.storyId,this.audio,this.id,this.name,this.image,this.refId,this.desc,this.index,this.isActive,this.views,this.date,this.isBookmark,this.isFav});

  factory StoryModel.fromFirestore(DocumentSnapshot doc) {

    Map data = doc.data() as Map;

    return StoryModel(
      id: doc.id,
      name: data['name'] ??'',
      image: data['image']??'',
      refId: data['refId']??'',
      storyId: data['storyId']??'',
      desc: data['desc']??'',
      index: data['index']??0,
      isActive: data['is_active']??false,
      date: data['date']??'',
      views: data['views']??0,
      audio: data['audio']??'',
      isBookmark: data['is_bookmark']??false,
      isFav: data['is_favourite']??false,
    );
  }

  factory StoryModel.fromJson(Map<String, dynamic> data) {
    return StoryModel(
      image: data['image'],
      name: data['name'],
      refId: data['refId'],
      storyId: data['storyId'],
      index: data['index'],
      views: data['views'],
      desc: data['desc'],
      isActive: data['is_active'],
      date: data['date'],
      isBookmark: data['is_bookmark'],
      audio: data['audio'],
      isFav: data['is_favourite'],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['refId'] = this.refId;
    data['storyId'] = this.storyId;
    data['desc'] = this.desc;
    data['index'] = this.index;
    data['is_active'] = this.isActive;
    data['date'] = this.date;
    data['views'] = this.views;
    data['is_bookmark'] = this.isBookmark;
    data['is_favourite'] = this.isFav;
    data['audio'] = this.audio;

    return data;
  }


}
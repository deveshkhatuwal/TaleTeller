import 'dart:convert';
import 'dart:typed_data';
import 'package:delta_markdown/delta_markdown.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storyadminpanel/controller/home_controller.dart';
import 'package:storyadminpanel/model/story_model.dart';
import '../ui/common/common.dart';
import 'package:markdown/markdown.dart' as mark;
import 'data/FirebaseData.dart';
import 'data/key_table.dart';
import 'package:intl/intl.dart';

class StoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController storyIdController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  RxString audioUrl = ''.obs;
  Uint8List webImage = Uint8List(10);
  QuillController descController = QuillController.basic();

  RxBool isImageOffline = false.obs;

  StoryModel? storyModel;
  RxBool isLoading = false.obs;

  String oldCategory = '';

  StoryController({this.storyModel});

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  RxString date = ''.obs;
  DateTime customDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();

    date(formatter.format(DateTime.now()));

    if (storyModel != null) {

      String fileName = storyModel!.image!.split("%2F").last;

      String file = fileName.split("?").first;


      String audioFileName = storyModel!.audio!.split("%2F").last;

      String audioFile = audioFileName.split("?").first;

      oldCategory='';
      nameController.text = storyModel!.name!;
      imageController.text = file;
      // imageController.text = storyModel!.image!;
      audioUrl.value = audioFile;
      // audioUrl.value = storyModel!.audio!;
      oldCategory=nameController.text;
      storyIdController.text = storyModel!.storyId!;

      if(storyModel!.desc!=null&& storyModel!.desc!.isNotEmpty){
        Delta delta = new Delta()..insert(removeAllHtmlTags(storyModel!.desc ?? ""));
        final doc = Document.fromDelta(delta);
        descController = QuillController(document: doc, selection: TextSelection.collapsed(offset: 0));
      }

      date(storyModel!.date);
      customDate = formatter.parse(storyModel!.date!);

    }
  }





  bool checkStoryIdExist(HomeController controller){


    List<String> storyIdList = [];


    for(int i = 0;i<controller.storyList.length;i++){

      storyIdList.add(controller.storyList[i].storyId!);

    }


    print("storyIdlisyt---------${controller.storyList.length}-----------${storyIdList.length}");



    bool isExist = storyIdList.contains(storyIdController.text);

    print("id---------${isExist}");


    return isExist;

  }


  addStory(BuildContext context, HomeController controller,
      Function function) async {
    if (checkValidation(context,controller)) {
      String url = await uploadFile(pickImage!);
      String audioUrl = await uploadAudio();

      StoryModel firebaseHistory = new StoryModel();

      firebaseHistory.name = nameController.text;
      firebaseHistory.storyId = storyIdController.text;
      firebaseHistory.image = url;
      firebaseHistory.audio = audioUrl;
      firebaseHistory.refId = controller.category.value;
      firebaseHistory.index = await FirebaseData.getLastIndexFromTable(KeyTable.storyList);
      firebaseHistory.desc = quillDeltaToHtml(descController.document.toDelta());
      firebaseHistory.date = date.value;
      firebaseHistory.isActive = true;
      firebaseHistory.views = 0;
      firebaseHistory.isBookmark = false;
      firebaseHistory.isFav = false;

      FirebaseData.insertData(
          context: context,
          map: firebaseHistory.toJson(),
          tableName: KeyTable.storyList,
          function: () {
            isLoading(false);
            function();
          });
    }
  }

//
  bool checkValidation(BuildContext context,HomeController controller) {
    // if(isNotEmpty(storyIdController.text)){
      if (isNotEmpty(nameController.text)) {
        if(isNotEmpty(descController.plainTextEditingValue.text.toString().trim())) {

          // if (isNotEmpty(audioUrl.value)) {



          if (isNotEmpty(imageController.text)) {



            // if(!checkStoryIdExist(controller)){


              isLoading(true);
              return true;



            // }else{
            //
            //   showCustomToast(
            //       message: 'Story id already exist..', title: 'Error', context: context);
            //   return false;
            // }



          } else {
            showCustomToast(
                message: 'Choose Image', title: 'Error', context: context);
            return false;
          }


          // } else {
          //   showCustomToast(
          //       message: 'Choose Audio', title: 'Error', context: context);
          //   return false;
          // }


        }else{
          showCustomToast(
              message: 'Enter Story...', title: 'Error', context: context);

          return false;
        }
      } else {
        showCustomToast(
            message: 'Enter name...', title: 'Error', context: context);
        return false;
      }
    // }else{
    //   showCustomToast(
    //       message: 'Enter story Id...', title: 'Error', context: context);
    //   return false;
    // }
  }

  String quillDeltaToHtml(Delta delta) {
    final convertedValue = jsonEncode(delta.toJson());
    final markdown = deltaToMarkdown(convertedValue);
    final html = mark.markdownToHtml(markdown);
    return html;
  }


  editStory(HomeController homeController,BuildContext context,Function function) async {

    if (checkValidation(context,homeController)) {

      String  url = imageController.text;

      if(imageController.text != storyModel!.image!){

        if(pickImage != null) {
          url = await uploadFile(pickImage!);
        }
      }


      if(audioUrl.value != storyModel!.audio!){

        if(result != null){
          audioUrl.value = await uploadAudio();
        }

      }

      storyModel!.name = nameController.text;
      storyModel!.storyId = storyIdController.text;

      if(pickImage != null){
        storyModel!.image = url;
      }else{
        storyModel!.image = storyModel!.image;
      }


      if(result != null){
        storyModel!.audio = audioUrl.value;
      }else{
        storyModel!.audio = storyModel!.audio;
      }



      storyModel!.refId = homeController.category.value;
      storyModel!.desc = quillDeltaToHtml(descController.document.toDelta());
      storyModel!.date = date.value;




      FirebaseData.updateData(context: context,
          map: storyModel!.toJson(),
          tableName: KeyTable.storyList,
          doc: storyModel!.id!,
          function: () {
            isLoading(false);
            function();
          });

    }
  }


  Future<String> uploadFile(XFile _image) async {
    try {
      final fileBytes = await _image.readAsBytes();
      var reference =
          FirebaseStorage.instance.ref().child("files/${_image.name}");

      UploadTask uploadTask = reference.putData(
          fileBytes,
          SettableMetadata(
              contentType:
                  "image/${getFileExtension(_image.name).replaceAll('.', '')}"));

      return await getUrlFromTask(uploadTask);
    } catch (e) {
      print('error in uploading image for : ${e.toString()}');
      return '';
    }
  }

  Future<String> uploadAudio() async {

    try{

      Uint8List fileBytes = result!.files.first.bytes!;
      String fileName = result!.files.first.name;

      var reference =
      FirebaseStorage.instance.ref().child('uploads/$fileName',);

      UploadTask  uploadTask= reference.putData(fileBytes, SettableMetadata(
          contentType:
          "audio/mpeg"));

      return await getUrlFromTask(uploadTask);

    }catch(e){
      return '';
    }
  }


  getUrlFromTask(  UploadTask  uploadTask)async{
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      print("complete=====true");
    // ignore: body_might_complete_normally_catch_error
    }).catchError((error) {
      print("error=====$error");
    });
    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }
  String getFileExtension(String fileName) {
    try {
      return "." + fileName.split('.').last;
    } catch (e) {
      return '';
    }
  }

  XFile? pickImage;
  final picker = ImagePicker();
  FilePickerResult? result;

  openFile() async {
     result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['mp3','aac','wav'],allowMultiple: false,);


    if (result != null) {
      String fileName = result!.files.first.name;
      print("sfdfsdf==$fileName");

      audioUrl.value = fileName;

    }else{
      audioUrl.value = '';
    }

  }



  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    pickImage = image;

    if (image != null) {
      imageController.text = pickImage!.name;
      var f = await pickImage!.readAsBytes();
      isImageOffline(false);
      webImage = f;
      isImageOffline(true);
    }
  }
}

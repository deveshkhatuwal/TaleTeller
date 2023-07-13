import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/data/FirebaseData.dart';
import 'package:storyadminpanel/model/category_model.dart';
import 'package:storyadminpanel/model/slider_model.dart';
import 'package:storyadminpanel/util/constants.dart';
import '../model/story_model.dart';
import '../ui/home/home_page.dart';
import 'data/key_table.dart';

class HomeController extends GetxController{

  CategoryModel? categoryModel =null;
  StoryModel? storyModel =null;
  RxString category = ''.obs;
  RxString story = ''.obs;

  RxString storyNotification = ''.obs;

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<String> allCategoryList = <String>[].obs;
  RxList<StoryModel> storyList = <StoryModel>[].obs;
  RxList<StoryModel> storyListNotification = <StoryModel>[].obs;

  RxList<String> allStoryListNotification = <String>[].obs;
  RxList<String> sliderList = <String>[].obs;
  RxBool isLoading = false.obs;


  setCategoryModel(CategoryModel categoryModel){
    this.categoryModel = categoryModel;
    changeAction(actionEditCategory);
  }

  setStoryModel(StoryModel storyModel){
    this.storyModel = storyModel;
    changeAction(actionEditStory);
  }

  @override
  void onInit() {

    super.onInit();
    fetchCategoryData();
    fetchStoryData();
    fetchSliderData();

    fetchStoryDataForNotification();
  }

  fetchCategoryData() async {

    print("category----exist");
    isLoading(true);
    categoryList = <CategoryModel>[].obs;
    allCategoryList = <String>[].obs;
    category("");
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection(KeyTable.categoryList).get();

    if (querySnapshot.size > 0 && querySnapshot.docs.length > 0) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      categoryList = <CategoryModel>[].obs;
      for (int i = 0; i < list1.length; i++) {
        categoryList.add(CategoryModel.fromFirestore(list1[i]));
        allCategoryList.add(CategoryModel.fromFirestore(list1[i]).name!);
      }
      isLoading(false);
      category((list1[0]).id);
      categoryList.refresh();
      allCategoryList.refresh();


      print("categoryList------${categoryList.length}");

    } else {
      isLoading(false);
   }
  }


  fetchStoryData() async {
    isLoading(true);
    storyList = <StoryModel>[].obs;
    story("");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(KeyTable.storyList).get();
    if (querySnapshot.size > 0 && querySnapshot.docs.length > 0) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      storyList = <StoryModel>[].obs;
      for (int i = 0; i < list1.length; i++) {


        print("storyNAme===${StoryModel.fromFirestore(list1[i]).name}");


        storyList.add(StoryModel.fromFirestore(list1[i]));
      }
      isLoading(false);
      story((list1[0]).id);
      storyList.refresh();
    } else {
      isLoading(false);
    }
  }


  fetchStoryDataForNotification() async {
    isLoading(true);
    storyListNotification = <StoryModel>[].obs;
    allStoryListNotification = <String>[].obs;
    storyNotification("");
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection(KeyTable.storyList).get();

    if (querySnapshot.size > 0 && querySnapshot.docs.length > 0) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      storyListNotification = <StoryModel>[].obs;
      for (int i = 0; i < list1.length; i++) {
        storyListNotification.add(StoryModel.fromFirestore(list1[i]));
        allStoryListNotification.add(StoryModel.fromFirestore(list1[i]).name!);
      }
      isLoading(false);
      // storyNotification((list1[0]).id);
      storyListNotification.refresh();
      allStoryListNotification.refresh();
    } else {
      isLoading(false);
    }
  }



  fetchSliderData() async {
    sliderList = <String>[].obs;
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection(KeyTable.sliderList).get();
    if (querySnapshot.size > 0 && querySnapshot.docs.length > 0) {
      List<DocumentSnapshot> list1 = querySnapshot.docs;
      List<DocumentSnapshot> sliderList1 = [];
      for (int i = 0; i < list1.length; i++) {
        sliderList1.add((list1[i]));
      }

      sliderList = <String>[].obs;

       sliderList1.forEach((element) async {

        SliderModel sliderModel = SliderModel.fromFirestore(element);

        DocumentSnapshot? isExist = await FirebaseData.  checkStoryExist(sliderModel.storyId!, KeyTable.storyList);

        if(isExist != null && isExist.exists){


          bool isCatExist = await FirebaseData.checkCategoryExists(StoryModel.fromFirestore(isExist).refId!);

          if(isCatExist){
            sliderList.add(sliderModel.storyId!);
            sliderList.refresh();
          }
          print("isCatExist----${isCatExist}");
        }
      });

      print("slider0-------${sliderList.length}");
      sliderList.refresh();
    }
  }

}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storyadminpanel/controller/home_controller.dart';
import 'package:storyadminpanel/model/slider_model.dart';
import '../ui/common/common.dart';
import 'data/FirebaseData.dart';
import 'data/key_table.dart';

class HomeSliderController extends GetxController {


  RxBool isLoading=false.obs;





  addSlider(BuildContext context, HomeController controller,Function function) async {
    isLoading(true);

    if(!controller.sliderList.contains(controller.story.value)) {
      SliderModel sliderModel = new SliderModel();
      sliderModel.index =
      await FirebaseData.getLastIndexFromTable(KeyTable.sliderList);
      sliderModel.storyId = controller.story.value;

      FirebaseData.insertData(
          context: context,
          map: sliderModel.toJson(),
          tableName: KeyTable.sliderList,
          function: () {
            isLoading(false);
            function();
            controller.fetchSliderData();
          });
    }else{
      isLoading(false);
      showCustomToast(context: context, message: 'Already Exists..');
    }
  }










}

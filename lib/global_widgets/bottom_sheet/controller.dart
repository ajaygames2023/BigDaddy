import 'package:get/get.dart';

class CasinoBottomSheetController extends GetxController{

  bool isLoading = false;

  bool switchValue = false;

  toggleIsLoading(){
    isLoading = !isLoading;
    update();
  }

  toggleSwitchValue(bool val){
    switchValue = val;
    update();
  }

}
import 'dart:io';
import 'dart:typed_data';

import 'package:camera_macos/camera_macos_controller.dart';
import 'package:casino/global_widgets/camera_macos.dart';
import 'package:casino/global_widgets/camera_windows.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/router/routes.dart';
import '../../domain/models/card_details.dart';
import '../../domain/repositories/api_calls.dart';
import '../../utils/helper/helper.dart';
import 'widgets/documents.dart';

class VerificationController extends GetxController {

  bool isLoading = true;
  bool isNext = false;
  final ImagePicker picker = ImagePicker();
  File? image;
  File? panImage;
  File? aadharFrontImage;
  File? aadharBackImage;
  bool isAadhar = true;
  String groupValue = 'Aadhar Card';
  Map<String, dynamic>? panVerified;
  Map<String, dynamic>? aadharVerified;
  CardDetails? panDetails;
  CardDetails? aadharDetails;
  String panStatus = '';
  String aadharStatus = '';
  bool isAadharVerified = false;
  bool isPanVerified = false;

  TextEditingController aadharNo = TextEditingController();
  TextEditingController panNo = TextEditingController();

   final GlobalKey cameraKey = GlobalKey(debugLabel: "cameraKey");
  late CameraMacOSController macOSController;
  String? deviceId;

  void loadingData(){
    isLoading = !isLoading;
    update();
  }

  @override
  void onInit() {
    getAllData();
    // TODO: implement onInit
    //APPROVE
    //PENDING
    super.onInit();
  }

  // void pickImageFromCamera() async {
  //   image = await picker.pickImage(source: ImageSource.camera);
  //   update();
  // }

  //   void pickImageFromGallery() async {
  //   image = await picker.pickImage(source: ImageSource.gallery);
  //   update();
  // }

  void chooseWhichImage(String typeImage,{File? image} ) {
    switch(typeImage) {
      case 'fontAadhar':
        chooseWhereToPickImage(typeImage,image);
        break;
      case 'backAadhar' :
        chooseWhereToPickImage(typeImage,image);
        break;
      case 'pan':
        chooseWhereToPickImage(typeImage,image);
        break;
      default:
        chooseWhereToPickImage(typeImage,image);
        break;
    }
  }

  void chooseImage(String imageType) {
    Get.dialog(CameraWindows());
    // Get.dialog( Camera(callBack: (image) async { 
    // //   var a = await image;
    // // print('aaa'+ await image.toString());
    //   chooseWhichImage(imageType,image : image ?? File(''));},
    //   ),);
  }

    // image picker
  void chooseWhereToPickImage(String imageType,File? image) async {
   //  image = await pickImage('camera');
      setImageToController(imageType,image);
      update();
    // Get.defaultDialog(
    //   title: 'Select Image',
    //   content: SizedBox(
    //     height: 100,
    //     width: 200,
    //     child: ListView(
    //       children: [
    //         // ListTile(
    //         //   title: const Align(
    //         //       alignment: Alignment.centerLeft,
    //         //       child: CasinoText(text: 'Select from gallery')),
    //         //   onTap: () async {
                
    //         //    image =  await pickImage('gallery');
    //         //    setImageToController(imageType,image);
    //         //    update();
    //         //    Get.back();
    //         //   },
    //         // ),
    //         ListTile(
    //           title: const Align(
    //               alignment: Alignment.centerLeft,
    //               child: CasinoText(text: 'Open camera')),
    //           onTap: () async {
    //             image = await pickImage('camera');
    //             setImageToController(imageType,image);
    //             update();
    //            Get.back();
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }


    void setImageToController(String imageType, File? image) {
      if(image!.path != '') {
         switch (imageType) {
      case 'pan':
        panImage = image;
        break;
      case 'fontAadhar':
        aadharFrontImage = image;
        break;
      case 'backAadhar':
        aadharBackImage = image;
        break;
      }
     update();
    }
   
  }

  //  Future<XFile> pickImage(
  //   String type,
  // ) async {
  //   XFile? image;
  //   switch (type) {
  //     case 'camera':
  //     const XTypeGroup typeGroup = XTypeGroup(
  //       label: 'images',
  //       extensions: <String>['jpg', 'png', 'pdf'],
  //     );
  //     image = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
  //     //  image = await picker.pickImage(source: ImageSource.camera,imageQuality: 5);
  //       break;
  //     case 'gallery':
  //       image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 5);
  //       break;
  //   }
  //   return image ?? XFile('');
  // }

  void getDocumentType(String value) {
    if(value == 'P') {
      groupValue = 'PAN';
    } else {
      groupValue = 'Aadhar Card';
    }
    update();
  }

  // void onToggle(bool value) {
  //   print(value);
  //   //isAadhar = !value;
  //   update();
  // }


  void verifyDoc() {
    switch(groupValue) {
      case 'PAN':
        panVerify();
        break;
      case 'Aadhar Card':
        aadharVerify();
        break;
    }
  }

    // pan verification
  void panVerify() async {
    try {
      loadingData();
      var param = <String, dynamic>{
        'userId' : Helper.userId,
        'token': Helper.token,
        'name': Helper.customerName,
        'panNumber': '12345678', 
        'state': 'Select State',
        'dob': '3-8-1997',
      };
      if (panImage != null) {
        panVerified = await ApiCallRepo.instance.panVerify(param, panImage ?? File(''));
        if (panVerified?["respCode"] == 100 ||
            panVerified?["respCode"] == 101) {
              getAllData();
              Helper.toast('Pan Card Upload Successfully', );
              update();
        } else {
          Helper.toast(panVerified?["message"], );
        }
      } else {
        
        Helper.toast('Please upload pan', );
      }
      
    } catch (e) {
      rethrow;
    } finally {
      loadingData();
    }
  }

    // aadhar verification
  void aadharVerify() async {
    try {
      loadingData();
      var param = <String, dynamic>{
        'userId': Helper.userId,
        'token': Helper.token,
        'name': Helper.customerName,
        'aadharNumber': '1234567890000',
        'state': 'Select State',
        'dob': '3-8-1997',
      };
      if (aadharFrontImage != null) {
        aadharVerified = await ApiCallRepo.instance.aadharVerify(param, aadharFrontImage ?? File(''), aadharBackImage?? File(''));
        if (aadharVerified?["respCode"] == 100) {
            getAllData();
            Helper.toast(aadharVerified?["message"],);
            update();
        } else {
          Helper.toast(aadharVerified?["message"],
              );
        }
      } else {
        Helper.toast('Please upload aadhar', );
      }
    } catch (e) {
      rethrow;
    } finally {
      loadingData();
    }
  }

    getAllData() async {
    try {
      loadingData();
      panDetails = await ApiCallRepo.instance.getPanDetails(Helper.instance.getParams());
      aadharDetails = await ApiCallRepo.instance.getAadharDetails(Helper.instance.getParams());
      if (panDetails != null) {
        getPanDetails();
      }
      if (aadharDetails != null) {
        getAadharDetails();
      }
    } catch (e) {
      rethrow;
    } finally {
      loadingData();
    }
  }

  void getPanDetails() {
    panStatus = panDetails?.status ?? '';
    if(panStatus == 'APPROVE'){
      isPanVerified = true;
    }
    if(panStatus != '') {
      isNext = true;
    }
    update();
  }

  void getAadharDetails() {
    aadharStatus = aadharDetails?.status ?? '';
    if(aadharStatus == 'APPROVE'){
      isAadharVerified = true;
    }
    if(aadharStatus != '') {
      isNext = true;
    }
    update();
  }

  void onNext(){
    if(image != null) {
        image = null;
        update();
      }
      Get.toNamed(Routes.items);
  }

  getCameraImage() {
    return Documents(groupValue: groupValue,
        panImage: panImage,
        aadharBackImage: aadharBackImage,
        aadharFrontImage: aadharFrontImage,
        callBack: (typeImage) { chooseWhichImage(typeImage);
        update();});
  }

  Widget getImage() {
    if(groupValue == 'PAN') {
      if(panStatus == '') {
        getCameraImage();
      }  else{
        return getPanImage();
      }
    } 
    if(groupValue == 'Aadhar Card') {
      if(aadharStatus == '' ) {
        getCameraImage();
      }  else{
        return getAadharImage();
      }
    }
    return getCameraImage();
  }

  Widget getStatusPanImage(String image) {
    return SizedBox(
      height: 400,
      width: 400,
      child:Image.asset(image) ,
    );
  }

  Widget getPanImage() {
    if(panStatus == 'APPROVE') {
      return getStatusPanImage('assets/images/success_pan.jpg');
    }
    if(panStatus == 'PENDING') {
      return getStatusPanImage('assets/images/pending_pan.jpg');
    }
    return const SizedBox.square();
  }

  Widget getStatusWidget(String image1,String image2) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 800,
                child: Image.asset(image1)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 800,
                child: Image.asset(image2)),
            ),
          ),
        ],
      );
  }

  Widget getAadharImage() {
    if(aadharStatus == 'APPROVE') {
      return getStatusWidget('assets/images/success_aadhar_font.jpg','assets/images/success_back_font.jpg');
    }
    if(panStatus == 'PENDING') {
      return getStatusWidget('assets/images/pending_aadhar_front.jpg','assets/images/pending_aadhar_back.jpg');
    }
    return const SizedBox.square();
  }
}
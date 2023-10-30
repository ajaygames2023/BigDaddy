import 'package:casino/global_widgets/text.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  XFile? image;
  XFile? panImage;
  XFile? aadharFrontImage;
  XFile? aadharBackImage;
  bool isAadhar = true;
  String groupValue = 'Aadhar Card';
  Map<String, dynamic>? panVerified;
  Map<String, dynamic>? aadharVerified;
  CardDetails? panDetails;
  CardDetails? aadharDetails;
  String panStatus = '';
  String aadharStatus = '';


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

  void pickImageFromCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    update();
  }

    void pickImageFromGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void chooseWhichImage(String typeImage ) {
    switch(typeImage) {
      case 'fontAadhar':
        chooseWhereToPickImage(typeImage,aadharFrontImage);
        break;
      case 'backAadhar' :
        chooseWhereToPickImage(typeImage,aadharBackImage);
        break;
      case 'pan':
        chooseWhereToPickImage(typeImage,panImage);
        break;
      default:
        chooseWhereToPickImage(typeImage,panImage);
        break;
    }
  }

    // image picker
  void chooseWhereToPickImage(String imageType,XFile? image) async {
     image = await pickImage('camera');
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

    void setImageToController(String imageType, XFile? image) {
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

   Future<XFile> pickImage(
    String type,
  ) async {
    XFile? image;
    switch (type) {
      case 'camera':
      print('camera');
      const XTypeGroup typeGroup = XTypeGroup(
        label: 'images',
        extensions: <String>['jpg', 'png'],
      );
      image = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
      //  image = await picker.pickImage(source: ImageSource.camera,imageQuality: 5);
        break;
      case 'gallery':
        image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 5);
        break;
    }
    return image ?? XFile('');
  }

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
        'name': 'pan',
        'panNumber':'BWRPP4132U', 
        'state': 'Select State',
        'dob': '',
      };
      if (panImage != null) {
        panVerified = await ApiCallRepo.instance.panVerify(param, panImage!);
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
        'name': 'aadharName.text',
        'aadharNumber': '444489761234',
        'state': 'Select State',
        'dob': '',
      };
      if (aadharFrontImage != null && aadharBackImage != null) {
        aadharVerified = await ApiCallRepo.instance
            .aadharVerify(param, aadharFrontImage!, aadharBackImage!);
        if (aadharVerified?["respCode"] == 100) {
            getAllData();
            Helper.toast(aadharVerified?["message"],);
            update();
        } else {
          Helper.toast(aadharVerified?["message"],
              );
        }
      } else {
        loadingData();
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
    if(panStatus != '') {
      isNext = true;
    }
    update();
  }

  void getAadharDetails() {
    aadharStatus = aadharDetails?.status ?? '';
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
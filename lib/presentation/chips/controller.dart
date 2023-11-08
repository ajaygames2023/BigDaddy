import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/kycdata_status/index.dart';
import '../../domain/models/messages.dart';
import '../../domain/models/profile.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/api_calls.dart';
import '../../global_widgets/text.dart';
import '../../utils/helper/helper.dart';
import '../home/controller.dart';
class ChipController extends GetxController {

  String totalAmount = '0';
  String valueAmount = '0';
  String discountAmount = '0';
  String faceValue ='0';
  String gstAmount = '0';
  bool isDiscount = false ;
  TextEditingController discountPercentage = TextEditingController();
  TextEditingController mobileNbr= TextEditingController();
  TextEditingController otp= TextEditingController();
  TextEditingController name= TextEditingController();
  TextEditingController amount= TextEditingController();
  TextEditingController discountValue= TextEditingController();
  Map<String,dynamic>? kycStatus;
  List<KycDataStatus>? kycDataStatus;
  String userName = '';
  String customerName = '';
  String userKycStatus = '';
  String userId = '';
  bool isOTPField = false;
  bool isNameField = false;
  Message? sendOtp; 
  Map<String, dynamic>? verifyOtp;
  Map<String, dynamic>? updateProfile;
  String btnTitle = 'Search';
  String otpStatus = '';
  MyProfile? myProfile;
  UserDetails? userDetails;
  bool isResendOTP = false;
  bool isDisableUserBtn = false;
  List<String> discountListType = ['Dealer','Management','Employment'];
  String discountType = 'Dealer';
  String discountGroupValue = 'Percentage';

  String lessDiscount = '0';

    @override
  void onInit() async {
    super.onInit();
  }

    String getUserName() {
      if(kycDataStatus != null) {
         if(kycDataStatus![0].aadharData!.status =="APPROVE") {
            return kycDataStatus![0].aadharData!.name ?? '';
          } else if(kycDataStatus![1].panData!.status =="APPROVE"){
            return kycDataStatus![1].panData!.name ?? '';
          } else {
            return '';
          }
      }
      return '';
  }

  Color getOtpStatusColor() {
    if(otpStatus == 'OTP send successfully'){
      return CasinoColors.black;
    } else if(otpStatus == 'Verified') {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  String getKycStatusVar() {
    if(kycDataStatus != null) {
      if(kycDataStatus![1].panData!.status =="APPROVE") {
        userId = kycDataStatus![1].panData!.userId.toString();
        return kycDataStatus![1].panData!.status ??'';
      } else if(kycDataStatus![0].aadharData!.status =="APPROVE") {
        userId = kycDataStatus![0].aadharData!.userId.toString();
        return kycDataStatus![0].aadharData!.status ?? '';
      } else {
        return 'PENDING';
      }
    } else {
      return 'PENDING';
    }
  }

  void getKycStatus() async {
    try {
      final params = <String, dynamic>{
      "userData": mobileNbr.text,
    };
      kycStatus = await ApiCallRepo.instance.getKycStatus(params);
      if (kycStatus?['respCode'] == 100) {
        kycDataStatus?.addAll(kycStatus?['respCode']);
        userName = getUserName();
        userKycStatus = getKycStatusVar();
        if(userKycStatus != 'APPROVE') {
          btnTitle = 'Verify';
          isOTPField = true;
          otpStatus = 'OTP send successfully';
          signInOtp();
          isResendOTP = true;
          update();
        } else {
          if(kycDataStatus!.first.aadharData!.status == 'APPROVE') {
            Helper.customerId = kycDataStatus!.first.aadharData!.userId.toString();
            Helper.customerName = kycDataStatus!.first.aadharData!.name.toString();
            Helper.customerMobileNbr = '';

          } else {
            Helper.customerId = kycDataStatus!.first.panData!.userId.toString();
            Helper.customerName = kycDataStatus!.first.panData!.name.toString();
            Helper.customerMobileNbr = '';
          }
          update();
          //  btnTitle = 'Verify';
          // isOTPField = true;
          // otpStatus = 'OTP send successfully';
          // signInOtp();
          // isResendOTP = true;
          // update();

        }
       // getProfile();
        update();
      } else if(kycStatus?['respCode'] == 200) {
        btnTitle = 'Verify';
        isOTPField = true;
        otpStatus = 'OTP send successfully';
        signInOtp();
        isResendOTP = true;
        update();
        // btnTitle = 'Submit';
        // isNameField = true;
        // update();
        // Helper.toast(kycStatus?['message']);
      } else if(kycStatus?['respCode'] == 113) {
      //  isNameField = true;
        btnTitle = 'Verify';
        isOTPField = true;
        otpStatus = 'OTP send successfully';
        signInOtp();
        isResendOTP = true;
        Helper.toast(kycStatus?['message'],status: 'OTP Status');
        update();
      } else {
        Helper.toast(kycStatus?['message']);
      }
    } catch (e) {
      rethrow;
    } finally {
    }
  }

    // login(): used to verify otp and login to home
  void login() async {
    final params = <String, dynamic>{
      "otp": otp.text,
      'mobileNbr': mobileNbr.text,
      ...Helper.instance.getParams(),
    };
    try {
      verifyOtp = await ApiCallRepo.instance.verifyOtp(params);
      if (verifyOtp?['respCode'] == 100) {
      userDetails = UserDetails.fromJson(verifyOtp?['respData']!);
        Helper.token = userDetails?.token ?? '';
        isNameField = true;
        btnTitle = 'Submit';
        isResendOTP = false;
        otpStatus = 'Verified';
        update();
      } else {
        Helper.toast(verifyOtp?['message']);
      }
    } catch (e) {
      rethrow;
    } finally {
      print(btnTitle);
    }
  }

  void updateProfileData() async {
    Map<String,dynamic> param = <String,dynamic>{
      'screenName':name.text,
      ...Helper.instance.getParams(),
    };
    try {
      updateProfile = await ApiCallRepo.instance.updateProfile(param);
      if(updateProfile?['respCode'] == 100) {
        Helper.toast('Profile Updated.',status: 'Profile Status');
        getProfile();
      }
    } catch (e) {
      rethrow;
    } finally {
    }
  }


String totalAmountWithDiscount(String value,String discountPercentage) {
  if(isDiscount) {
    discountAmount = ((1/num.parse(discountPercentage))*num.parse(value)).toStringAsFixed(2);
  return (num.parse(value) - ((1/num.parse(discountPercentage))*num.parse(value))).toStringAsFixed(2);
  }
  return value;
}

String getDiscountAmount(String value) {
  if(value!= '0'){
  if(isDiscount) {
    discountAmount = ((2 * num.parse(getGST(value)))).toStringAsFixed(2);
  return discountAmount;
  }}
  return value;
}

String getFaceValue(String value){
  if(value == '') {
    return '0';
  }
  if(value != '0'){
    faceValue = ((num.parse(value)-(2 * num.parse(getGST(value))))).toStringAsFixed(2);
    return faceValue;
  // if(isDiscount) {
    
  // } else {
  //     faceValue = (num.parse(value)).toStringAsFixed(2);
  //     return faceValue;
  // }
  }
  return value;
}


String getGST(String amount) {
  return ((num.parse(amount) - num.parse(getDiscount(amount))) * 0.14).toStringAsFixed(2);
}

String getDiscount(String amount) {
  return (num.parse(amount) * 0.21875).toStringAsFixed(2);
}

String getDiscount1(String amount,{required String discountValue, required String discountType,required bool isDiscount}) {
  if(isDiscount) {
    if(discountType == 'Fixed') {
      return (num.parse(discountValue)).toStringAsFixed(2);
    } else {
      return ((num.parse(amount) * num.parse(discountValue)) / 100).toStringAsFixed(2);
    }
  } else {
    return '0';
  }
}

String getAmountBeforeDiscount(String amount) {
  return (num.parse(amount) - num.parse(getDiscount(amount))).toStringAsFixed(2);
}

Widget getRowWidget({required String title,required String amount}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        child: Align(
          alignment: Alignment.centerRight,
          child: CasinoText(text: '$title : ',fontWeight: FontWeight.bold,)),
      ),
      const SizedBox(width: 20,),
      SizedBox(
          child: CasinoText(text: 'Rs $amount',align: TextAlign.right,)),
    ],
  );
}

  selectDiscountModeType(String val){
    discountGroupValue = val;
    discountValue.text = '0';
      if(discountValue.text.isNotEmpty) {
    lessDiscount = getDiscount1(valueAmount, discountValue: discountValue.text, discountType: discountGroupValue,isDiscount: isDiscount);
    }
    getFaceValue(valueAmount);
    update();
  }

  // signInOtp(): used to send otp
  void signInOtp() async {
    try {
      final params = <String, dynamic>{
        'mobileNbr': mobileNbr.text,
        ...Helper.instance.getParams()
      };
      sendOtp = await ApiCallRepo.instance.login(params);
      if (sendOtp?.respCode == 100) {
        Helper.toast(sendOtp?.message ?? '',status: 'OTP Status');
      } else {
        Helper.toast(sendOtp?.message ?? '');
      }
      update();
    } catch (e) {
      rethrow;
    } finally {
    }
  }

  void getProfile() async {
    try {
      myProfile = await ApiCallRepo.instance.myProfile(Helper.instance.getParams());
      if(myProfile != null) {
        Helper.customerName = myProfile!.screenName ?? '';
        Helper.customerId = myProfile!.userId.toString();
        Helper.customerMobileNbr = myProfile!.mobileNbr.toString();
      }
      isDisableUserBtn = true;
        update();

    } catch (e) {
      rethrow;
    } finally {
    }
  }

  bool getIsKycData() {
    return myProfile!.isPanCardVerified == 'YES' ? true : false;
  }

  void generateChipInvoice() {
     ItemsController controller = Get.put(ItemsController());
   controller.openPaymentMode(name: 'abc',userId: '1',isKyc: true,amount: valueAmount.toString(),discount: getDiscount(valueAmount),amountAfterDiscount: valueAmount.toString());
  }

  void clearData() {
    totalAmount = '0';
    valueAmount = '0';
    discountAmount = '0';
    faceValue ='0';
    gstAmount = '0';
    isDiscount = false ;
    discountPercentage.text = '' ;
    mobileNbr.text = '' ;
    otp.text ='';
    name.text ='';
    userName = '';
    customerName = '';
    userKycStatus = '';
    userId = '';
    isOTPField = false;
    isNameField = false;
    btnTitle = 'Search';
    otpStatus = '';
    isResendOTP = false;
    isDisableUserBtn = false;
    amount.text = '';
    myProfile = null;
    update();
  }

  
}

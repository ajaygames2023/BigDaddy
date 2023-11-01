import 'aadhar_status.dart';
import 'pan_status.dart';

class KycDataStatus {
  AadharData? aadharData;
  PanData? panData;

  KycDataStatus({this.aadharData});

  KycDataStatus.fromJson(Map<String, dynamic> json) {
    aadharData = json['aadharData'] != null
        ?  AadharData.fromJson(json['aadharData'])
        : null;
    panData = json['panData'] != null
        ?  PanData.fromJson(json['panData'])
        : null;
  }
}


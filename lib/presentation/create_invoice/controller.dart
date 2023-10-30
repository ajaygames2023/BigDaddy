import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:casino/global_widgets/dialog.dart';
import 'package:casino/utils/helper/helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sms_mms/sms_mms.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import '../../domain/domain/api_constants.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceController extends GetxController {

  bool isLoading = true;
  String link = Get.arguments['link'];
  String? onDownload;
  bool isWhatsAppInstalled = false;
  String path = '';
  final doc = pw.Document();

  void loadingData(){
    isLoading = !isLoading;
    update();
  }


  // getPdfAndShare() async {
  //   downloadInvoice(Urls.pdf);
  // }

   void downloadInvoice({required String url,String? shareBy}) async {
    try {
      print("Update Started");
      final downloadPath = File("${await getDownloadPath()}/invoice_2.pdf");
      Dio().download(url, downloadPath.path,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          onDownload = "${(received / total * 100).toStringAsFixed(0)}%";
        }
      }).then((value) async {
        print(value.data);
         print("Update Completed");
         print(downloadPath.path);
         shareDocuments(invoicePath: downloadPath.path,shareBy: shareBy);
         
         
         //sendByWhatsApp(downloadPath.path);
        // print(await File(downloadPath.path).exists()); 
        // var permission = await Permission.manageExternalStorage.request();
        // if(permission.isGranted) {
        //   if(shareBy == 'sms') {
        //     sendSmsMms(downloadPath.path);
        //   } else {
        //     sendByWhatsApp(downloadPath.path);
        //   }
          
        // } else {
        //   await Permission.manageExternalStorage.isGranted;
        // }

      });
    } catch (e) {
      print(e);
    }
  }

  void shareDocuments({required String invoicePath,String? shareBy}) {
    switch(shareBy) {
      case 'whatsApp':
      Helper.toast('Implement for phone yet.');
      case 'sms':
      Helper.toast('Implement for phone yet.');
      case 'share':
      sharePdfViaExternalApp(path: invoicePath);
      case 'print':
      printPdf(invoicePath);
    }
  }

   Future<void> sharePdfViaExternalApp({required String path}) async {
     await Share.shareXFiles([XFile(path)], text: 'Invoice');
    // if (result.status == ShareResultStatus.success) {
    //     Helper.toast('Having some error to share invoice');
    // } else {
    //   Helper.toast('Having some error to share invoice');
    // }
  }

   Future<void> isInstalled() async {
    final val = await WhatsappShare.isInstalled(
      package: Package.businessWhatsapp
    );
    print('Whatsapp Business is installed: $val');
  }


  Future<String?> getDownloadPath() async {
    Directory? dPata;
    if(Platform.isAndroid) {
      dPata = await getExternalStorageDirectory();
      if (dPata != null) {
        var split = dPata.path.toString().split("Android");
        return "${split[0]}Download/";
      } else {
        return null;
      }
    } else {
      dPata = await getApplicationSupportDirectory();
      return dPata.path;
    }
  }

  void sendSmsMms(String path) async {
    await SmsMms.send(
          recipients: [Helper.customerMobileNbr.toString()],
          message: 'This is your casino invoice',
          filePath: path,
      );
  }

   void printPdf(String path) async {
      final file = File(path); // File
      final bytes = await file.readAsBytes(); 
      await Printing.layoutPdf(onLayout: (_) => bytes);
  }

    void sendByWhatsApp(String path) async {
    await isInstalled().then((_) async {
            await WhatsappShare.shareFile(
            phone: Helper.customerMobileNbr,
            filePath: [path],
          );
          });
  }


}

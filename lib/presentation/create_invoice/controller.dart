import 'dart:async';
import 'dart:io';

import 'package:casino/utils/helper/helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import '../../domain/domain/api_constants.dart';

class InvoiceController extends GetxController {

  bool isLoading = true;
  String link = Get.arguments['link'];
  String? onDownload;
  bool isWhatsAppInstalled = false;

  void loadingData(){
    isLoading = !isLoading;
    update();
  }


//  Future<void> shareFile() async {
//       try {
//         //   final bytes = await rootBundle.load('assets/images/invoice.pdf');
//         // final list = bytes.buffer.asUint8List();
// getExternalStorageDirectory();
//         // final tempDir = await getTemporaryDirectory();
//         // final file = await File('${tempDir.path}/invoice.pdf').create();
//         // file.writeAsBytesSync(list);
//         // print('abc'+file.path);
//         Directory? directory = await getExternalStorageDirectory();
//         //Directory? directory = await getApplicationDocumentsDirectory();
//         // ignore: deprecated_member_use
//         print(directory!.path);
//     //     await WhatsappShare.share(
//     //   text: 'Whatsapp share text',
//     //   linkUrl: 'https://flutter.dev/',
//     //   phone: '918375840007',
//     // );
//       await WhatsappShare.shareFile(
//        // text: 'Whatsapp share text',
//         phone: '918375840007',
//         filePath: [directory.path],
//       );
//        // await Share.shareFiles([(file.path)], text: 'Great picture');
//     } on PlatformException catch (e) {
//       print("Exception while taking screenshot:" + e.toString());
//     }
//   }

  Future<void> shareFile() async {
    // final bytes = await rootBundle.load('assets/images/invoice.pdf');
    // final list = bytes.buffer.asUint8List();

    // final tempDir = await getTemporaryDirectory();
    // final file = await File('${tempDir.path}/invoice.pdf').create();
    // file.writeAsBytesSync(list);
    
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
   // debugPrint(file.path);

    await WhatsappShare.shareFile(
      phone: '918375840007',
      filePath: [directory!.path],
    );
  }


  getPdfAndShare() async {
    // await WhatsappShare.share(
    //   phone: '911234567890',
    //   linkUrl: Urls.pdf
    //   );
    downloadInvoice(Urls.pdf);
   // launchUrl(Uri.parse(Urls.pdf),mode: LaunchMode.externalApplication,);
  }

    void downloadInvoice(String url) async {
    try {
      print("Update Started");
      final downloadPath = File(
          "${await getDownloadPath()}invoice_2.pdf");
      Dio().download(url, downloadPath.path,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          onDownload = "${(received / total * 100).toStringAsFixed(0)}%";
        }
      }).then((value) async {
        
        // print("Update Completed");
        // print(downloadPath.path);
        // print(await File(downloadPath.path).exists()); 
        var permission = await Permission.manageExternalStorage.request();
        if(permission.isGranted) {
          await isInstalled().then((_) async {
            await WhatsappShare.shareFile(
            phone: Helper.customerMobileNbr,
            filePath: [downloadPath.path],
          );
          });
        } else {
          await Permission.manageExternalStorage.isGranted;
        }

      });
    } catch (e) {
      print(e);
    }
  }
   Future<void> isInstalled() async {
    final val = await WhatsappShare.isInstalled(
      package: Package.businessWhatsapp
    );
    print('Whatsapp Business is installed: $val');
  }


  Future<String?> getDownloadPath() async {
    var dPata = await getExternalStorageDirectory();
    if (dPata != null) {
      var split = dPata.path.toString().split("Android");
      return "${split[0]}Download/";
    } else {
      return null;
    }
  }


}

import 'dart:io';

import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/presentation/create_invoice/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/domain/api_constants.dart';
import '../../global_widgets/text.dart';
import '../../utils/constants/colors.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Invoice extends GetView<InvoiceController> {
  const Invoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back(result: true);
        }, icon: const Icon(Icons.arrow_back_ios,color: Color.fromARGB(255, 250, 198, 65),)),
        backgroundColor:  CasinoColors.secondary,
        title: const CasinoText(text: 'Invoice',color: Color.fromARGB(255, 250, 198, 65),fontWeight: FontWeight.w600,),
        actions: [
          IconButton(onPressed: () async {
            controller.downloadInvoice(url :controller.link,shareBy: 'share');
            // try {
            //     final bytes = await rootBundle.load('assets/images/invoice.pdf');
            //     final list = bytes.buffer.asUint8List();

            //     final tempDir = await getTemporaryDirectory();
            //     final file = await File('${tempDir.path}/invoice.pdf').create();
            //     file.writeAsBytesSync(list);
                
            //     // ignore: deprecated_member_use
            //     await Share.shareFiles([(file.path)], text: 'Great picture');
            // } on PlatformException catch (e) {
            //   print("Exception while taking screenshot:" + e.toString());
            // }
          }, icon: const Icon(Icons.share,color: Color.fromARGB(255, 250, 198, 65),)),
          const SizedBox(width: 20,),
          IconButton(onPressed: () async => controller.downloadInvoice(url :controller.link,shareBy: 'print'), icon: const Icon(Icons.print,color: Color.fromARGB(255, 250, 198, 65),)),
          const SizedBox(width: 20,)
        ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
             child: SfPdfViewer.network(controller.link),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                 CasinoButton(title: 'Send Via WhatsApp',height: 50,width: 200,onTap: () {},),
                
                 CasinoButton(title: 'Send Via SMS',height: 50,width: 200,onTap: () {},)
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }
}
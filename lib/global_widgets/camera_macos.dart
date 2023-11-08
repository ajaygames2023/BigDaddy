import 'dart:io';

import 'package:camera_macos/camera_macos_arguments.dart';
import 'package:camera_macos/camera_macos_controller.dart';
import 'package:camera_macos/camera_macos_device.dart';
import 'package:camera_macos/camera_macos_file.dart';
import 'package:camera_macos/camera_macos_platform_interface.dart';
import 'package:camera_macos/camera_macos_view.dart';
import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/dialog.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as pathJoiner;

class Camera extends StatefulWidget {
  const Camera({
    this.callBack,
    super.key});
  final Function(File? image)? callBack;

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final GlobalKey cameraKey = GlobalKey(debugLabel: "cameraKey");
  late CameraMacOSController macOSController;
  PictureFormat selectedPictureFormat = PictureFormat.jpg;
  File? lastPictureTaken;
  String? deviceId;
  List<CameraMacOSDevice> videoDevices = [];
    @override
  void initState() {
    getDeviceList().then((value){
      deviceId = videoDevices.first.deviceId;
    });
    super.initState();
  }

  getDeviceList() async {
    videoDevices = await CameraMacOS.instance.listDevices(deviceType: CameraMacOSDeviceType.video);
  }

  getDevices() {
    Get.dialog(DialogBox(title: 'Camera Devices', 
      child: Container(
        height: 100,
        width: 200,
        color: CasinoColors.white,
        child: ListView.builder(
          itemCount: videoDevices.length,
          itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              setState(() {
                deviceId = videoDevices[index].deviceId;
              });
              Get.back();
            },
            child: SizedBox(
              height: 30,
              child: CasinoText(text: videoDevices[index].localizedName.toString(),color: (deviceId == videoDevices[index].deviceId) ? CasinoColors.green : CasinoColors.black,align: TextAlign.start,)),
          );
        }),
      ))).then((value) {
      });

  }

    Future<String> get imageFilePath async => pathJoiner.join(
      (await getApplicationDocumentsDirectory()).path,
      "P_${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}.${selectedPictureFormat.name.replaceAll("PictureFormat.", "")}");
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          CameraMacOSView(
          deviceId: deviceId,
          key: cameraKey,
          fit: BoxFit.fill,
          cameraMode: CameraMacOSMode.photo,
          onCameraInizialized: (CameraMacOSController controller) async {
              setState((){
                  macOSController = controller;
              });
          },
    ),

    Positioned(
      top: 20,
      left: 20,
      child: CasinoButton(
        height: 40,
        title: 'Change Camera Device',
        onTap: (){
          getDevices();
        },
    
      ),
    ),

    Positioned(
      bottom: 20,
      left: MediaQuery.of(context).size.width * 0.4,
      child: CasinoButton(
        height: 50,
        width: 200,
        title: 'Select image',onTap: () async {
        CameraMacOSFile? file = await macOSController.takePicture();
        String filename = await imageFilePath;
        File f = File(filename);
        try {
          if (file != null) {
            try {
              if (f.existsSync()) {
                f.deleteSync(recursive: true);
              }
              f.createSync(recursive: true);
              f.writeAsBytesSync(file.bytes!);
              lastPictureTaken = f;
            } catch (e) {
              print(e);
            }
            // try {
            //   if (lastPictureTaken != null) {
            //     Uri uriPath = Uri.file(lastPictureTaken!.path);
            //     if (await canLaunchUrl(uriPath)) {
            //       await launchUrl(uriPath);
            //     }
            //   }
            // } catch (e) {
            //   print(e);
            // }
           // final tempDir = (await getTemporaryDirectory()).path;
            // print(await getTemporaryDirectory().then((value) => print(value)));
            // XFile? picture = XFile.fromData(file.bytes!,
            // path: tempDir,
            // name: 'write_your_own_title.jpg');
            //  OpenFile.open(file.bytes.);
            widget.callBack!(f);
            Get.back();
          }
        } catch (e) {
          debugPrint('Error occured while taking picture: $e');
          return;
        }
      },),
    )
        ],
      ),
    );
  }
}
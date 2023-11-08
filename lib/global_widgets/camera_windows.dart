import 'package:flutter/material.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';

class CameraWindows extends StatefulWidget {
  const CameraWindows({super.key});

  @override
  State<CameraWindows> createState() => _CameraWindowsState();
}

class _CameraWindowsState extends State<CameraWindows> {
  int cameraId = -1;
  List<CameraDescription> cameras = <CameraDescription>[];

    @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    fetchCameraId();
  }

  void fetchCameraId() async {
    ResolutionPreset resolutionPreset = ResolutionPreset.veryHigh;
    cameras = await CameraPlatform.instance.availableCameras();
    cameraId = await CameraPlatform.instance.createCamera(
        cameras.first,
        resolutionPreset,
      );
  }
  @override
  Widget build(BuildContext context) {
    return CameraPlatform.instance.buildPreview(cameraId);
  }
}
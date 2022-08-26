import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:get/get.dart';

class ControllerCamera extends GetxController {
  @override
  void dispose() {
    super.dispose();
    controller.value?.dispose();
  }

  @override
  onReady() {
    isCameraStarting.value = true;
    cameraInit().catchError(onCameraError).whenComplete(() {
      controller.value = CameraController(
        _cameras[0],
        ResolutionPreset.max,
      );
      isCameraStarting.value = false;
    });
    super.onReady();
  }

  Rx<CameraController?> controller = Rx(null);
  late List<CameraDescription> _cameras;

  RxBool isCameraInUse = RxBool(false);
  RxBool isCameraLoading = RxBool(false);
  RxBool isCameraStarting = RxBool(false);

  Rx<Uint8List> file = Uint8List(0).obs;

  Future<void> cameraInit() async {
    _cameras = await availableCameras().catchError(onCameraError);
  }

  onCameraError(Object error) {
    const String errorCode = "CameraAccessDenied";

    if (error is CameraException) {
      switch (error.code) {
        case errorCode:
          throw "Camera access denied";
        default:
          throw "Unknown error";
      }
    }
  }

  Future<void> takePicture() async {
    if (controller.value?.value.isTakingPicture ?? true) {
      print("======== CAMERA IS BUSY. CANCELLING... ========");
      return;
    }

    try {
      print("======== TAKING PHOTO... ========");
      file.value = await controller.value
              ?.takePicture()
              .then((value) async => await value.readAsBytes()) ??
          await XFile("").readAsBytes();
      print("======== PHOTO TAKEN SUCCESSFULLY ========");
      print("======== PHOTO PATH ${file.value.toString()}");
    } catch (err) {
      rethrow;
    }
  }
}

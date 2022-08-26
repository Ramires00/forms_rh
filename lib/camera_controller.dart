import 'package:camera/camera.dart';
import 'package:get/get.dart';

class ControllerCamera extends GetxController {
  Rx<CameraController?> controller = Rx(null);
  late List<CameraDescription> _cameras;

  Future<void> cameraInit() async {
    _cameras = await availableCameras();
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

  @override
  void dispose() {
    super.dispose();
    controller.value?.dispose();
  }

  @override
  onReady() {
    super.onReady();
    cameraInit().whenComplete(() {
      controller.value = CameraController(
        _cameras[1],
        ResolutionPreset.max,
      );
    });
  }
}

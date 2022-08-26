import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:forms_rh/camera_controller.dart';
import 'package:forms_rh/text_field.dart';
import 'package:forms_rh/view.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  //#region textEditingController
  final TextEditingController nomeCompleto = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController cpf = TextEditingController();
  final TextEditingController rg = TextEditingController();
  final TextEditingController dataDeNascimento = TextEditingController();
  //#endregion textEditingController

  final ControllerCamera _controllerCamera =
      Get.put<ControllerCamera>(ControllerCamera());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Forms"),
      ),
      body: Obx(
        () => _controllerCamera.isCameraStarting.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        camera(),
                        SizedBox(
                          height: 28,
                        ),
                        CustomTextField(
                          nomeCompleto,
                          "Nome Completo",
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        CustomTextField(
                          email,
                          "E-mail",
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        CustomTextField(
                          cpf,
                          "CPF",
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        CustomTextField(
                          rg,
                          "RG",
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        CustomTextField(
                          dataDeNascimento,
                          "Data de Nascimento",
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        submitButton(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  //#region submitButton
  submitButton() => SizedBox(
        width: 250,
        child: ElevatedButton(
          style: submitButtonStyle(),
          onPressed: send,
          child: Text("BOTA"),
        ),
      );

  send() => Get.to(View(), arguments: {
        "Nome Completo": nomeCompleto.text,
        "Data de Nascimento": dataDeNascimento.text,
        "RG": rg.text,
        "CPF": cpf.text,
        "E-mail": email.text,
      });

  submitButtonStyle() => ElevatedButton.styleFrom(
        primary: Colors.red,
      );
  //#endregion submitButton

  //#region photoButton

  void onPhotoButton() {
    if (!_controllerCamera.isCameraStarting.value &&
        !_controllerCamera.isCameraInUse.value) {
      isCameraIsLoading();
      _controllerCamera.controller.value?.initialize().whenComplete(() {
        isCameraInUse();
        isCameraIsLoading();
      });
    } else {
      isCameraInUse();
    }
  }
  //#endregion photoButton

  //#region camera
  Widget camera() => !_controllerCamera.isCameraInUse.value
      ? cameraPlaceholder()
      : cameraPreview();

  cameraPlaceholder() => TextButton(
        onPressed: onPhotoButton,
        child: Container(
          width: 210,
          height: 210,
          color: Colors.red.withOpacity(0.05),
          child: Icon(
            Icons.person,
            size: 100,
            color: Colors.red,
          ),
        ),
      );

  cameraPreview() => Row(
        children: [
          SizedBox(
            width: 210,
            height: 210,
            child: Obx(
              () => _controllerCamera.isCameraInUse.value
                  ? !_controllerCamera.isCameraLoading.value
                      ? CameraPreview(_controllerCamera.controller.value!)
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
                  : Text("Câmera desligada"),
            ),
          ),
          buttonPhoto(),
          Obx(() => _controllerCamera.file.value.lengthInBytes <= 0
              ? Container()
              : Image.memory(_controllerCamera.file.value))
        ],
      );

  buttonPhoto() => FloatingActionButton(
        onPressed: () async => await _controllerCamera.takePicture(),
        child: Icon(Icons.add, color: Colors.red),
      );

  //#endregion camera

  isCameraIsLoading() => _controllerCamera.isCameraLoading.value =
      !_controllerCamera.isCameraLoading.value;

  isCameraInUse() => _controllerCamera.isCameraInUse.value =
      !_controllerCamera.isCameraInUse.value;
}

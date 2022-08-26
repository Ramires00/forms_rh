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
  final TextEditingController nomeCompleto = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController cpf = TextEditingController();
  final TextEditingController rg = TextEditingController();
  final TextEditingController dataDeNascimento = TextEditingController();

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
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async =>
                      await _controllerCamera.controller.value?.initialize(),
                  child: Container(
                    width: 180,
                    height: 180,
                    color: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
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
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () => Get.to(View(), arguments: {
                      "Nome Completo": nomeCompleto.text,
                      "Data de Nascimento": dataDeNascimento.text,
                      "RG": rg.text,
                      "CPF": cpf.text,
                      "E-mail": email.text,
                    }),
                    child: Text("BOTA"),
                  ),
                ),
                SizedBox(
                  width: 400,
                  height: 400,
                  child: Obx(() => _controllerCamera.controller.value != null
                      ? CameraPreview(_controllerCamera.controller.value!)
                      : Text("Não foi possível carregar a câmera")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

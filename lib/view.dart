import 'package:flutter/material.dart';
import 'package:get/get.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Forms"),
      ),
      body: Container(
        child: Center(
          child: (Get.arguments != null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Get.arguments["Nome Completo"]),
                    Text(Get.arguments["E-mail"]),
                    Text(Get.arguments["CPF"]),
                    Text(Get.arguments["RG"]),
                    Text(Get.arguments["Data de Nascimento"]),
                  ],
                )
              : Text("null"),
        ),
      ),
    );
  }
}

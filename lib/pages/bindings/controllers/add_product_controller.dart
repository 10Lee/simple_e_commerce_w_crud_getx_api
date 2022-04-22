import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/home_controller.dart';
import 'package:simple_crud_getx_airsoft_api/repositories/connect_api.dart';

class AddProductController extends GetxController {
  Rx<TextEditingController>? nameController;
  Rx<TextEditingController>? priceController;
  Rx<TextEditingController>? captionController;
  Rx<TextEditingController>? descriptionController;

  Rx<File> fileContainer = Rx(File(""));
  HomeController homeController = Get.find<HomeController>();

  final ImagePicker _imagePicker = ImagePicker();
  ConnectApi connectApi = Get.find<ConnectApi>();
  RxBool isLoading = false.obs;

  void showImagePicker(String from) async {
    if (from == 'gallery') {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      fileContainer.value = File(image!.path);
    } else {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.camera);
      fileContainer.value = File(image!.path);
    }
    Get.back();
  }

  void uploadFileImage() {
    if (fileContainer.value.existsSync()) {
      isLoading.value = true;
      connectApi
          .uploadImage(fileContainer.value, captionController!.value.text)
          .then((api) {
        if (api.success == true) {
          Get.defaultDialog(
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))))),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
              content: Row(
                children: [
                  Text("${api.data.file}"),
                  const SizedBox(width: 10.0),
                  Text("${api.data.caption}"),
                ],
              ));
        } else {
          Get.snackbar("Message", api.message);
        }
        homeController.refresh();
      });
    } else {
      Get.snackbar("Message", "Photo still empty!");
    }
  }

  void postNewAirsoft() {
    Map<String, dynamic> postData = {
      "success": true,
      "message": "Success posting new product",
      "data": {
        "id": homeController.catalogs.length + 100,
        "name": nameController!.value.text,
        "description": descriptionController!.value.text,
        "price": priceController!.value.text,
        "photo": fileContainer.value.path.split('/').last,
      },
    };

    var jsonData = jsonEncode(postData);

    connectApi.postApi(jsonData).then((api) {
      if (api.success == true) {
        Get.snackbar("Success", api.message);

        nameController!.value.text = "";
        priceController!.value.text = "";
        captionController!.value.text = "";
        descriptionController!.value.text = "";

        isLoading.value = false;
        Get.back();
      } else {
        Get.snackbar("Error", api.message);
      }
    });
  }

  void saveForm() async {
    uploadFileImage();
    postNewAirsoft();
  }

  @override
  void onInit() {
    nameController = Rx(TextEditingController());
    priceController = Rx(TextEditingController());
    captionController = Rx(TextEditingController());
    descriptionController = Rx(TextEditingController());
    super.onInit();
  }
}

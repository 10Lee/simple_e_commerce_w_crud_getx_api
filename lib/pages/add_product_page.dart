import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/_controllers.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({Key? key}) : super(key: key);

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  AddProductController controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Product Form'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Form(
                  key: globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.nameController!.value,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Product Name"),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.priceController!.value,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Price"),
                          prefixText: "Rp. ",
                          prefixStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      const Text(
                        "Upload Image",
                        style: TextStyle(color: Colors.white60, fontSize: 16.0),
                      ),
                      const SizedBox(height: 30.0),
                      Obx(
                        () {
                          if (controller.fileContainer.value.existsSync()) {
                            return InkWell(
                              onTap: () => _uploadImageDialog(),
                              child: ClipRRect(
                                child: Image.file(
                                  controller.fileContainer.value,
                                  height: 100.0,
                                  width: 100.0,
                                ),
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () => _uploadImageDialog(),
                              child: Container(
                                width: double.infinity,
                                height: 100.0,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/no_image.png'),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        controller: controller.captionController!.value,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Image Caption",
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        controller: controller.descriptionController!.value,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Description",
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                controller.saveForm();
                              }
                            },
                            child: Center(
                              child: Text("Submit"),
                            ),
                          ),
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: () => Get.offAllNamed('/'),
                            child: Center(
                              child: Text("Back"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _uploadImageDialog() {
    return Get.defaultDialog(
      title: "Upload photo from..",
      content: Column(
        children: [
          ListTile(
            onTap: () => controller.showImagePicker('gallery'),
            title: const Text("Gallery"),
          ),
          const Divider(),
          ListTile(
            onTap: () => controller.showImagePicker('camera'),
            title: const Text("Camera"),
          ),
        ],
      ),
    );
  }
}

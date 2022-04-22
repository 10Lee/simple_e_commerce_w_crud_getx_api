import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/constants.dart';
import 'package:simple_crud_getx_airsoft_api/extensions/word_formatter.dart';
import 'package:simple_crud_getx_airsoft_api/models/airsoft_model.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/home_controller.dart';

class CatalogTab extends StatelessWidget {
  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () => Get.offAllNamed('/add_product_page'),
          child: Icon(Icons.add)),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: controller.catalogs.length,
                itemBuilder: (context, index) {
                  final data = controller.catalogs[index];
                  return Stack(
                    children: [
                      _baseGridImage(data),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            width: 188.0,
                            height: 100.0,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black54,
                                  Colors.black87,
                                  Colors.black87,
                                  Colors.black,
                                  Colors.black,
                                  Colors.black38,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.name}",
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(height: 2.5),
                                Text(
                                  'Rp. ${WordFormatter.currency.format(data.price)}',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        right: 10.0,
                        child: Obx(
                          () {
                            AirsoftModel? isThisItemInCarts = controller.carts
                                .firstWhereOrNull(
                                    (chartItem) => chartItem.id == data.id);
                            if (isThisItemInCarts == null) {
                              return InkWell(
                                onTap: () =>
                                    controller.addSelectedItemToCart(data),
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.shopping_cart),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    onConfirm: () =>
                                        controller.removeItemFromCarts(data),
                                    title: "Warning",
                                    textConfirm: "Delete",
                                    content: const Text(
                                        "Are you sure want to delete this from cart?"),
                                    onCancel: () => Get.back(),
                                  );
                                },
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.close),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Widget _baseGridImage(AirsoftModel data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
        image: DecorationImage(
          image: NetworkImage("${Constants.imageUrl}/${data.imageUrl}"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

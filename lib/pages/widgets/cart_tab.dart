import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/extensions/word_formatter.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/_controllers.dart';

import '_widgets.dart';

class CartTab extends StatelessWidget {
  CartTab({Key? key}) : super(key: key);

  CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.carts.isEmpty
          ? Container()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10.0),
                    itemCount: controller.carts.length,
                    itemBuilder: (context, index) {
                      final cart = controller.carts[index];
                      return Dismissible(
                        key: Key("${cart.id}"),
                        confirmDismiss: (_) async {
                          controller.removeItemFromCarts(cart);
                          return false;
                        },
                        child: CustomListTile(model: cart, currentIndex: index),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Spend : Rp. ${WordFormatter.currency.format(controller.grandTotal.value)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              "PURCHASE",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/constants.dart';
import 'package:simple_crud_getx_airsoft_api/extensions/word_formatter.dart';
import 'package:simple_crud_getx_airsoft_api/models/airsoft_model.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/_controllers.dart';

class CustomListTile extends StatelessWidget {
  final AirsoftModel model;
  final int currentIndex;

  CustomListTile({
    Key? key,
    required this.model,
    required this.currentIndex,
  }) : super(key: key);

  CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15.0),
        Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage("${Constants.imageUrl}/${model.imageUrl}"),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2.85),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 200.0,
                height: 100.0,
                decoration: BoxDecoration(color: Colors.grey),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${model.name}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          "Qty : ${model.qty}",
                          style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "•",
                          style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "Rp. ${WordFormatter.currency.format(model.price * model.qty)}",
                          style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 2.85),
            Column(
              children: [
                InkWell(
                  onTap: () => controller.decreaseQty(model, currentIndex),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                InkWell(
                  onTap: () => controller.increaseQty(currentIndex),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

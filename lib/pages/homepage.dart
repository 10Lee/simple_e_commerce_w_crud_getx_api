import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/home_controller.dart';

import 'widgets/_widgets.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("😎Dorr.. Dorr.. BlackMarket😎"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          indicatorColor: Colors.white,
          tabs: [
            const Tab(text: "CATALOG", icon: Icon(Icons.menu_book_sharp)),
            Obx(
              () => Tab(
                text: "CART",
                icon: controller.carts.isEmpty
                    ? Icon(Icons.shopping_cart)
                    : Badge(
                        badgeContent: Text(
                          "${controller.carts.length}",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Icon(Icons.shopping_cart),
                      ),
              ),
            ),
            Tab(text: "TRANSACTION", icon: Icon(Icons.attach_money)),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          CatalogTab(),
          CartTab(),
          TransactionTab(),
        ],
      ),
    );
  }
}

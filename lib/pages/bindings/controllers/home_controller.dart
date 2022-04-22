import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_crud_getx_airsoft_api/models/airsoft_model.dart';
import 'package:simple_crud_getx_airsoft_api/repositories/connect_api.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  RxList<AirsoftModel> catalogs = <AirsoftModel>[].obs;
  ConnectApi apiController = Get.find<ConnectApi>();

  RxList<AirsoftModel> carts = <AirsoftModel>[].obs;
  RxBool isLoading = false.obs;
  GetStorage box = GetStorage();
  int page = 1;

  void extractApi() {
    isLoading.value = true;

    apiController.getApi(page).then((value) {
      catalogs.addAll(value);
      isLoading.value = false;
    });
  }

  void syncBoxWithCarts() {
    box.listenKey('items_cart', (newValue) {
      if (newValue is List) {
        carts.clear();
        carts.addAll(newValue.map((e) => AirsoftModel.fromMap(e)).toList());
      }
    });
  }

  void pullDataFromBox() {
    if (box.hasData('items_cart')) {
      List<dynamic> items_cart = box.read('items_cart');
      if (items_cart is List) {
        carts.clear();
        carts.addAll(items_cart.map((e) => AirsoftModel.fromMap(e)).toList());
      }
    }
    syncBoxWithCarts();
  }

  @override
  void onInit() {
    extractApi();
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
    pullDataFromBox();
  }

  void addSelectedItemToCart(AirsoftModel model) {
    model.qty = 1;
    carts.add(model);

    List<Map<String, dynamic>> items_cart =
        carts.map((e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
    Get.snackbar("Success", "Your selected item successfuly added into cart");
  }

  void removeItemFromCarts(AirsoftModel catalogItem) {
    carts.removeWhere((cartItem) => cartItem.id == catalogItem.id);

    List<Map<String, dynamic>> items_cart =
        carts.map((e) => e.toJson()).toList();
    box.write('items_cart', items_cart);
    Get.offAllNamed('/');
  }
}

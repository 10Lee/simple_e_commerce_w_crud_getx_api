import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_crud_getx_airsoft_api/models/airsoft_model.dart';

class CartController extends GetxController {
  RxList<AirsoftModel> carts = <AirsoftModel>[].obs;
  GetStorage box = GetStorage();
  RxInt grandTotal = 0.obs;

  void calculateGrandTotal() {
    grandTotal.value = 0;
    for (int i = 0; i < carts.length; i++) {
      grandTotal = grandTotal + (carts[i].price * carts[i].qty);
    }
  }

  void syncBoxWithCarts() {
    box.listenKey('items_cart', (newValue) {
      if (newValue is List) {
        carts.clear();
        carts.addAll(newValue.map((e) => AirsoftModel.fromMap(e)).toList());
        calculateGrandTotal();
      }
    });
  }

  void pullDataFromBox() {
    if (box.hasData('items_cart')) {
      List<dynamic> items_cart = box.read('items_cart');
      if (items_cart is List) {
        carts.clear();
        carts.addAll(items_cart.map((e) => AirsoftModel.fromMap(e)).toList());
        calculateGrandTotal();
      }
    }
    syncBoxWithCarts();
  }

  void increaseQty(int index) {
    carts[index].qty++;
    List<Map<String, dynamic>> items_cart =
        carts.map((e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  void decreaseQty(AirsoftModel model, int index) {
    if (model.qty == 1) {
      carts.removeWhere((e) => e.id == model.id);
    } else {
      // this two are the same results, either cart[index].qty or model.qty
      carts[index].qty--;
      // model.qty--;
    }
    List<Map<String, dynamic>> items_cart =
        carts.map((e) => e.toJson()).toList();
    box.write('items_cart', items_cart);
  }

  void removeItemFromCarts(AirsoftModel catalogItem) {
    carts.removeWhere((cartItem) => cartItem.id == catalogItem.id);

    List<Map<String, dynamic>> items_cart =
        carts.map((e) => e.toJson()).toList();
    box.write('items_cart', items_cart);
  }

  @override
  void onReady() {
    super.onReady();
    pullDataFromBox();
  }
}

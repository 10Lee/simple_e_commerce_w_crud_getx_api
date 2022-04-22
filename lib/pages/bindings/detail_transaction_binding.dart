import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/detail_transaction_controller.dart';

class DetailTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailTransactionController());
  }
}

import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/_controllers.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionController());
  }
}

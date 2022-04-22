import 'package:get/instance_manager.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/_controllers.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}

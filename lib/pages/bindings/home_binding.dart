import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/home_controller.dart';
import 'package:simple_crud_getx_airsoft_api/repositories/connect_api.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ConnectApi());
  }
}

import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/models/transaction_model.dart';
import 'package:simple_crud_getx_airsoft_api/repositories/connect_api.dart';

class TransactionController extends GetxController {
  RxList<TransactionModel> transList = <TransactionModel>[].obs;
  ConnectApi apiController = Get.find<ConnectApi>();

  RxBool isLoading = false.obs;

  void callTransactionApi() {
    isLoading.value = true;
    apiController.getTransactionApi().then((value) {
      transList.addAll(value);
      isLoading.value = false;
    });
  }

  @override
  void onReady() {
    callTransactionApi();
    super.onReady();
  }
}

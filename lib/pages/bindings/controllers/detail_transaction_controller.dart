import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/models/detail_transaction_model.dart';
import 'package:simple_crud_getx_airsoft_api/repositories/connect_api.dart';

class DetailTransactionController extends GetxController {
  RxList<DetailTransactionModel> detailList = <DetailTransactionModel>[].obs;

  ConnectApi apiController = Get.find<ConnectApi>();

  String get transactionDate => Get.arguments['trans_date'];
  String get transactionCode => Get.arguments['trans_code'];
  int get transactionId => Get.arguments['trans_id'];

  RxBool isLoading = false.obs;

  void getDetailDataFromApi() {
    isLoading.value = true;
    apiController.getDetailTransactionApi(transactionId).then((api) {
      detailList.addAll(api);
      isLoading.value = false;
    });
  }

  @override
  void onReady() {
    super.onReady();
    getDetailDataFromApi();
  }
}

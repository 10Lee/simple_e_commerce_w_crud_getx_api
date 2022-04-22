import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_crud_getx_airsoft_api/models/transaction_model.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/_controllers.dart';

class TransactionTab extends StatelessWidget {
  TransactionTab({
    Key? key,
  }) : super(key: key);

  TransactionController controller = Get.find<TransactionController>();

  TransactionModel? isThisTrInList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20.0),
      itemCount: controller.transList.length,
      itemBuilder: (context, index) {
        final dateSorted = controller.transList
          ..sort((item1, item2) => item2.date.compareTo(item1.date));
        final dataSortIndex = dateSorted[index];

        return InkWell(
          onTap: () {
            isThisTrInList = controller.transList.firstWhereOrNull(
                (element) => element.id == controller.transList[index].id);

            if (isThisTrInList == null) {
              print("NULLL");
            } else {
              print("NOT NULL");
              print(dataSortIndex.id);

              Get.toNamed('/detail_transaction', arguments: {
                'trans_code': dataSortIndex.transCode,
                'trans_date': dataSortIndex.date,
                'trans_id': dataSortIndex.id,
              });
            }
          },
          child: isThisTrInList == null
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.all(20.0),
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${dataSortIndex.date}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text("• TR-Code : ${dataSortIndex.transCode} •")
                    ],
                  ),
                )
              : Container(
                  color: Colors.blue,
                  height: 100.0,
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_crud_getx_airsoft_api/pages/bindings/controllers/detail_transaction_controller.dart';
import 'package:simple_crud_getx_airsoft_api/constants.dart';

class DetailTransactionPage extends StatelessWidget {
  DetailTransactionController controller =
      Get.find<DetailTransactionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${controller.transactionCode}"),
      ),
      body: Obx(
        () => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.detailList.length,
          itemBuilder: (context, index) {
            final detailData = controller.detailList[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "${Constants.imageUrl}/${detailData.photo}",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Transaction Date : ${controller.transactionDate}",
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${detailData.qty}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40.0)),
                              TextSpan(
                                  text: ' pcs',
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        width: .5,
                        height: 100.0,
                        color: Colors.grey,
                      ),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Rp. ',
                                  style: TextStyle(fontSize: 20.0)),
                              TextSpan(
                                  text:
                                      '${NumberFormat.currency(decimalDigits: 1, symbol: "").format((detailData.price * detailData.qty) / 1000000)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40.0)),
                              TextSpan(
                                  text: ' Juta',
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DESCRIPTION',
                        style: TextStyle(
                            color: Colors.white54, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Text("${detailData.description}"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: const Divider(
                    height: .5,
                    color: Colors.white54,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

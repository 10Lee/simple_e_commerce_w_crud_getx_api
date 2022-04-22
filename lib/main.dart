import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'pages/bindings/_bindings.dart';
import 'pages/_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Airsoft Shop',
      theme: ThemeData.dark(),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          bindings: [
            HomeBinding(),
            CartBinding(),
            TransactionBinding(),
          ],
        ),
        GetPage(
          name: '/detail_transaction',
          page: () => DetailTransactionPage(),
          binding: DetailTransactionBinding(),
        ),
        GetPage(
          name: '/add_product_page',
          page: () => AddProductPage(),
          binding: AddProductBinding(),
        ),
      ],
      initialRoute: '/',
    );
  }
}

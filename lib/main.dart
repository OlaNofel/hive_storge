import 'package:flutter/material.dart';
import 'package:hive_cashe_storge_bloc/core/config/hive_config.dart';
import 'package:hive_cashe_storge_bloc/feature/product/view/product_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // await Hive.initFlutter();
  await hivesetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

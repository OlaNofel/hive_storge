import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Box? mybox;

hivesetup() async {
  mybox = await Hive.openBox("products");
}

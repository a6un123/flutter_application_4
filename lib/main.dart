import 'package:flutter/material.dart';
import 'package:flutter_application_4/utils/app_section.dart';
import 'package:flutter_application_4/view/splashscreen/splashscreen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox(AppSection.NOTEBOX); // step 1 - hive implement
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}

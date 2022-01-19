import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './blinding.dart';
import '../Components/bottom_navigation.dart';
import './Controllers/bottom_bar_controller.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: GetBuilder<BottomNavigationBarModel>(
        init: BottomNavigationBarModel(),
        builder: (c) => Scaffold(
          bottomNavigationBar: buttomNavigator(),
          body: c.currentScreen,
        ),
      ),
    );
  }
}

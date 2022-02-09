import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onmarket_test/Models/auth_times.dart';
import 'package:onmarket_test/wrapper.dart';
import 'package:provider/provider.dart';
import './blinding.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Models/modalprogrsshub.dart';

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
      home:    MultiProvider( providers:  [
              ChangeNotifierProvider<ModelHub>(
          create: (context) => ModelHub(),
        ),
         ChangeNotifierProvider<AuthTime>(
          create: (context) => AuthTime(),
        ),
        
        ],child: const Wrapper()) 
    );
  }
}

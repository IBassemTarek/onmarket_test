import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onmarket_test/Models/modalprogrsshub.dart';  
import 'package:provider/provider.dart';
import '../Components/bottom_navigation.dart';
import './Controllers/bottom_bar_controller.dart';

import 'Screens/signIn/signin.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            height: 20,
            width: 20,
            child: const Center(child: CircularProgressIndicator()));
        }
          else if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return MultiProvider(
      providers:  [
              ChangeNotifierProvider<ModelHub>(
          create: (context) => ModelHub(),
        ),
        ],
        child:  SignIn());
            } else {
              return  GetBuilder<BottomNavigationBarModel>(
        init: BottomNavigationBarModel(),
        builder: (c) => Scaffold(
          bottomNavigationBar: buttomNavigator(),
          body: c.currentScreen,
        ),
      );
            }
          } else {
            return Scaffold(
              body: Container(
            height: 20,
            color: Colors.white,
            width: 20,
                child: const Center(child: CircularProgressIndicator()),
              ),
            );
          }
        });
  }
}
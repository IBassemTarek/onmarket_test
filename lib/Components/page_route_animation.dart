import 'package:flutter/cupertino.dart';

class OnBoardingPageRoute extends PageRouteBuilder {
  final Widget widget;
  final Curve myAnimation;

  OnBoardingPageRoute({required this.widget,required this.myAnimation,required int duration})
      : super(
            transitionDuration: Duration(milliseconds: duration),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: myAnimation);
              return ScaleTransition(
                /* SlideTransition, FadeTransition */
                scale: animation,
                alignment: Alignment.center,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
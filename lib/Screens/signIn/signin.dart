import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:onmarket_test/Models/auth_times.dart';
import 'package:onmarket_test/Models/modalprogrsshub.dart';
import 'package:onmarket_test/Models/user.dart';
import 'package:provider/provider.dart'; 
import '../../Utils/constants.dart';
import 'custom_text_field.dart';
import '../../Services/auth.dart';
import 'dart:io';

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _auth = AuthService();
  String ?_email, _password;

  SignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHub>(context).isLoading,
        child: Builder(builder: (context) {
          return Form(
            key: _globalKey,
            child: ListView(
              children: [
                Container(
                  height: 0.43998 * _height,
                  width: _width,
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: [
                          kGradColor1.withOpacity(1),
                          kGradColor2.withOpacity(1),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0), 
                        stops: const [0.3, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _height * 0.03,
                      ),
                      Image.asset(
                        "assets/Logo.png",
                      ),
                      SizedBox(
                        height: _height * 0.046875,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: _width * 0.1207721,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(
                                          color: kHeaderColor.withOpacity(1),
                                          fontSize: 36)),
                              SizedBox(
                                height: _height * 0.02232143,
                              ),
                              Text("Sign In to your account",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: Colors.white)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.0725446 * _height,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.120773 * _width),
                  width: _width * 0.758454,
                  //  height: 0.068080*_height,
                  child: CustomTextField(
                    lableText: 'Email address',
                    hintText: "test@test.com",
                    onClick: (value) {
                      _email = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 0.049107 * _height,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.120773 * _width),
                  width: _width * 0.758454,
                  //  height: 0.068080*_height,
                  child: CustomTextField(
                    lableText: 'Password',
                    hintText: "12345678",
                    onClick: (value) {
                      _password = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 0.08800 * _height,
                ),
                Builder(
                  builder: (context) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.290773 * _width),
                    child: InkWell(
                      onTap: () async {
                        // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                        _validate(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: _width * 0.718454,
                        height: 0.058080 * _height,
                        decoration:   BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          color: kbackgroundColor.withOpacity(1),
                        ),
                        child: Text('Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(color: Colors.white, fontSize: 24)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.02116 * _height,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final _authTimes = Provider.of<AuthTime>(context , listen: false);
    final modelhud = Provider.of<ModelHub>(context,listen:false);
    modelhud.changeIsLoading(true);
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      
        try { 
          dynamic userData = await _auth.signIn(_email, _password);
          if (userData != null) {
            modelhud.changeIsLoading(false);
            UserModel user = _auth.userFromFirebaseUser(userData);
            // ignore: avoid_print
            print(user.id);
          }
      
          
        } catch (e) {
          if (_authTimes.tries == 2)
          {
            exit(0);
          }else {
            _authTimes.changeTries(_authTimes.tries +1 );
          }
          modelhud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        }
      }
    modelhud.changeIsLoading(false);
    }
  }

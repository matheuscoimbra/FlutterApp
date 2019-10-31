import 'dart:async';
import 'package:fisc/page/login/login_page.dart';
import 'package:fisc/page/login/user.dart';
import 'package:fisc/utils/utils.dart';
import 'package:flutter/material.dart';

import 'initial_page.dart';






class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Screen size;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      navigateFromSplash();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Scaffold(
        body: Center(
            child: Container(
                width: size.getWidthPx(300),
                height: size.getWidthPx(300),
                child: Image.network("https://seeklogo.com/images/B/brasao-do-estado-do-maranhao-cdr-v13-logo-FD8A4F4F6C-seeklogo.com.png"),))
    );
  }

  Future navigateFromSplash () async {

    /*String isOnBoard = await LocalStorage.sharedInstance.readValue(Constants.isOnBoard);
    print("isOnBoard  $isOnBoard");
    if(isOnBoard ==null || isOnBoard == "0"){*/
      //Navigate to OnBoarding Screen.

    Future<User> future = User.get();
    future.then((User usuario){
      if(usuario!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });

  }
}
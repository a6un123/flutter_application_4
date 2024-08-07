import 'package:flutter/material.dart';
import 'package:flutter_application_4/utils/color_Constants.dart';
import 'package:flutter_application_4/view/homescreen/homescreeen.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Homescreeen() ,));
    },);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.BLACK,
      body: Center(
           child: Lottie.asset("assets/animation/notapp_animation.json")
      ),
    );
  }
}
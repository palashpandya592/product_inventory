import 'package:flutter/material.dart';
import 'package:product_app/constant/app_assets.dart';

class BackGroundImage extends StatelessWidget {
  Widget? body;

  BackGroundImage({this.body});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.appLogo), fit: BoxFit.fill),
        ),
        child: body,
      ),
    );
  }
}

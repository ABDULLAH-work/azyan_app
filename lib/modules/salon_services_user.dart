import 'dart:ui';

import 'package:azyan/constance/component.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'auth_screen/login_screen.dart';

class SalonServicesUser extends StatelessWidget {
  const SalonServicesUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            bottom(
              borderColor: Colors.grey,
              Colortext: HexColor('#ff5555'),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: Colors.white.withOpacity(0),
              onPressed: () {
                PushToNextScreen(context, LoginScreen());
              },
              text: 'Login',
            ),
            SizedBox(
              height: 20.0,
            ),
            bottom(
              borderColor: Colors.grey,
              Colortext: HexColor('#ff5555'),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: Colors.white.withOpacity(0),
              onPressed: () {
                //PushToNextScreen(context, RegisterScreen());
              },
              text: 'Create New Service',
            ),
            SizedBox(
              height: 20.0,
            ),
            bottom(
              borderColor: Colors.grey,
              Colortext: HexColor('#ff5555'),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: Colors.white.withOpacity(0),
              onPressed: () {
                //sPushToNextScreen(context, RegisterScreen());
              },
              text: 'Login to Salon',
            ),
            SizedBox(
              height: 80.0,
            ),
          ],
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'AZYAN',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 35.0, fontWeight: FontWeight.w400,),
            ),
          ),
        ],
      ),
      
    );
  }
}

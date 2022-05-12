import 'package:azyan/constance/component.dart';
import 'package:azyan/contol_panel/add_salon/add_salon_screen.dart';
import 'package:azyan/contol_panel/management_salon_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Control Panel',
          style: ThemeData().textTheme.bodyText2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            bottom(
              borderColor: Colors.grey,
              Colortext: HexColor('#ff5555'),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: Colors.white.withOpacity(0),
              onPressed: () {
                PushToNextScreen(context, AddSalonScreen());
              },
              text: 'Add Salon',
            ),
            const SizedBox(
              height: 20.0,
            ),
            bottom(
              borderColor: Colors.grey,
              Colortext: HexColor('#ff5555'),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: Colors.white.withOpacity(0),
              onPressed: () {
                PushToNextScreen(context, ManagementSalonScreen());
              },
              text: 'Management Salon',
            ),
            const SizedBox(
              height: 20.0,
            ),
            bottom(
              borderColor: Colors.grey,
              Colortext: HexColor('#ff5555'),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: Colors.white.withOpacity(0),
              onPressed: () {},
              text: 'Management Users',
            ),
            const SizedBox(
              height: 20.0,
            ),
            bottom(
              borderColor: Colors.grey,
              Colortext: HexColor('#ff5555'),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: Colors.white.withOpacity(0),
              onPressed: () {},
              text: 'Management Services',
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

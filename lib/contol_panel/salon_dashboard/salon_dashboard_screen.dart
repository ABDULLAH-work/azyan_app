import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/contol_panel/chat_salon/chat_salon_screen.dart';
import 'package:azyan/shared/cotrol_panel_cubit/cubit.dart';
import 'package:azyan/shared/cotrol_panel_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class SalonDashboardScreen extends StatelessWidget {
  const SalonDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlPanelCubit,ControlPanelStates>(
      builder: (context, state) {
        return    Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    ControlPanelCubit.get(context).logOut(context);
                  }),
            ],
            title: Text('Salon Dashboard',style: TextStyle(color: Colors.red),),
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                bottom(
                  borderColor: Colors.red,
                  width:double.infinity,
                  height: 50,
                  color: HexColor('#EB4043'),
                  onPressed: () {
                    PushToNextScreen(context,
                        ChatSalonScreen()

                    );
                  },
                  text: 'Chats',
                  Colortext: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
      listener: (context,state){

      },
    );
  }
}

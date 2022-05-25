import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/contol_panel/chat_salon/chat_salon_details_screen.dart';
import 'package:azyan/shared/cotrol_panel_cubit/cubit.dart';
import 'package:azyan/shared/cotrol_panel_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSalonScreen extends StatelessWidget {
  const ChatSalonScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {



    return BlocConsumer<ControlPanelCubit, ControlPanelStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: state is! ControlPanelGetUserChatLoadingState
              ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildChatUserItem(
                  context,
                  ControlPanelCubit.get(context)
                      .chatUserNameSender
                      .toSet()
                      .toList()[index],
                  ControlPanelCubit.get(context)
                      .chatUserImageSender
                      .toSet()
                      .toList()[index],
                  ControlPanelCubit.get(context)
                      .chatUserUidSender
                      .toSet()
                      .toList()[index],
                  ControlPanelCubit.get(context)
                      .chatUserTokenSender
                      .toSet()
                      .toList()[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                );
              },
              itemCount: ControlPanelCubit.get(context)
                  .chatUserNameSender
                  .toSet()
                  .toList()
                  .length)
              : Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {

      },
    );
  }

  Widget buildChatUserItem(context, String name, String image, String uId,String token) {
    return InkWell(
      onTap: () {
        PushToNextScreen(context, ChatSalonDetailsScreen(name: name,image: image,uId: uId,token: token,));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(image),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              name,
            ),
          ],
        ),
      ),
    );
  }
}

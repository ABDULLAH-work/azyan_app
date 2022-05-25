import 'package:azyan/models/message_model.dart';
import 'package:azyan/shared/cotrol_panel_cubit/cubit.dart';
import 'package:azyan/shared/cotrol_panel_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSalonDetailsScreen extends StatelessWidget {
  String? name;
  String? image;
  String? uId;
  String? token;

  ChatSalonDetailsScreen({this.name,this.image,this.uId,this.token});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ControlPanelCubit.get(context).getMessage(uId!);

      return BlocConsumer<ControlPanelCubit, ControlPanelStates>(
        builder: (context, state) {
          return Scaffold(

            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.grey),
              backgroundColor: Colors.white,
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    name!,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            body:  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message =
                          ControlPanelCubit.get(context).messages[index];

                          if (uId!=
                              message.senderId) return buildMyMessage(message);

                          return buildMessage(message);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 15.0,
                          );
                        },
                        itemCount: ControlPanelCubit.get(context).messages.length),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(

                            controller: messageController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here ...'),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          color: Colors.red[500],
                          child: MaterialButton(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              ControlPanelCubit.get(context).sendMessage(
                                image:image!  ,
                                name: name!,
                                receiveId: uId!,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                                tokenReceiver: token!,
                              );
                              messageController.clear();

                            },
                            minWidth: 1.0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      );
    });
  }

  Widget buildMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          )),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Text(messageModel.text.toString()),
    ),
  );

  Widget buildMyMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          )),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Text(messageModel.text.toString()),
    ),
  );
}

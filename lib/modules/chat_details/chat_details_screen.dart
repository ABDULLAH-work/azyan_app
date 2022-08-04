import 'dart:ui';

import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/models/message_model.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/cubit_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  AddSalonModel? addSalonModel;
  String? name;
  String? image;
  String? uId;
  String? token;

  ChatDetailsScreen({this.addSalonModel, this.name, this.image, this.uId});

  var messageController = TextEditingController();
 // final ScrollController controllerScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    // controllerScroll.animateTo(
    //  // controllerScroll.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 500),
    //   curve: Curves.easeOut,
    // );
    return Builder(builder: (context) {
      AppCubit.get(context).getMessage(receiveId: addSalonModel?.uId ?? uId!);
      return BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true ,
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
                    backgroundImage:
                        NetworkImage('${addSalonModel?.image ?? image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    addSalonModel?.name ?? name!,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1548777123-e216912df7d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                             // controller: controllerScroll,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (AppCubit.get(context).messages.length ==
                                    index) {
                                  return Container(
                                    height: 28.0,
                                  );
                                }
                                var message =
                                    AppCubit.get(context).messages[index];

                                if (AppCubit.get(context).model.uId ==
                                    message.senderId)
                                  return buildMyMessage(message);

                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 15.0,
                                );
                              },
                              itemCount:
                                  AppCubit.get(context).messages.length + 1),
                        ),
                        SizedBox(
                          height: 10.0,
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
                                    AppCubit.get(context).sendMessage(
                                      image: addSalonModel?.image ?? image!,
                                      name: addSalonModel?.name ?? name!,
                                      receiveId: addSalonModel?.uId ?? uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                      tokenReceiver:
                                          addSalonModel?.token ?? token!,
                                    );
                                    messageController.clear();
                                    // controllerScroll.animateTo(
                                    //   controllerScroll.position.maxScrollExtent,
                                    //   duration: Duration(milliseconds: 500),
                                    //   curve: Curves.easeOut,
                                    // );
                                  },
                                  minWidth: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
              color: Colors.red.withOpacity(.8),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(
            messageModel.text.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
} 

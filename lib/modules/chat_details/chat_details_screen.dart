import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/models/message_model.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/cubit_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  AddSalonModel? addSalonModel;

  ChatDetailsScreen({this.addSalonModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getMessage(receiveId:addSalonModel!.uId.toString());

      return BlocConsumer<AppCubit, AppState>(
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
                    backgroundImage: NetworkImage('${addSalonModel!.image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    addSalonModel!.name.toString(),
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
                                    AppCubit.get(context).messages[index];

                                if (AppCubit.get(context).model.uId ==
                                    message.senderId) return buildMyMessage(message);

                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 15.0,
                                );
                              },
                              itemCount: AppCubit.get(context).messages.length),
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
                                        receiveId: addSalonModel!.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
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

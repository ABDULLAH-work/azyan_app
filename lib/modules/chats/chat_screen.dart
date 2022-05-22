import 'package:azyan/constance/component.dart';
import 'package:azyan/modules/chat_details/chat_details_screen.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/cubit_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: state is! AppCubitGetUserChatLoadingState
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildChatUserItem(
                      context,
                      AppCubit.get(context)
                          .chatUserName
                          .toSet()
                          .toList()[index],
                      AppCubit.get(context)
                          .chatUserImage
                          .toSet()
                          .toList()[index],
                      AppCubit.get(context)
                          .chatUserUid
                          .toSet()
                          .toList()[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemCount: AppCubit.get(context)
                      .chatUserName
                      .toSet()
                      .toList()
                      .length)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildChatUserItem(context, String name, String image, String uId) {
    return InkWell(
      onTap: () {
        PushToNextScreen(context, ChatDetailsScreen(name: name,image: image,uId: uId,));
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

import 'dart:convert';

import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/models/message_model.dart';
import 'package:azyan/modules/auth_screen/login_screen.dart';
import 'package:azyan/shared/cotrol_panel_cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:azyan/remote/cach_helper.dart';
import 'package:http/http.dart' as http;



class ControlPanelCubit extends Cubit<ControlPanelStates> {
  ControlPanelCubit() : super(ControlPanelInitialState());

  static ControlPanelCubit get(context) => BlocProvider.of(context);


  AddSalonModel  model = AddSalonModel();

  void getUserData(context) {
    emit(ControlPanelCubitGetOneSalonLoadingState());
    FirebaseFirestore
        .instance.collection('users')
        .doc(uId).get().then((value) {
      model = AddSalonModel.fromJson(value.data()!);
      emit(ControlPanelCubitGetOneSalonSuccessState());
       updateSalon(name:  model.name,
        email:  model.email,
        password:  model.password,
        phone:  model.phone,
        uId: uId,
        image:  model.image,
        state:  'salon',
        hair:  model.hair,
        face:  model.face,
        body:  model.body,
        description:  model.description,
        location:  model.location,
        stateWork:  model.stateWork,
        openOrClose:  model.openOrClose,
        hoursStart:  model.hoursStart,
        hoursEnd: model.hoursEnd,
        ratting:  model.ratting,
        uIdBody:  model.uIdBody,
        uIdFace:  model.uIdFace,
        uIdHair:  model.uIdHair,);
    }).catchError(
          (error) {
        print(
          error.toString(),
        );
        emit(
          ControlPanelCubitGetOneSalonErrorState(),
        );
      },
    );
  }


  void updateSalon({
    required String ?name,
    required String ?email,
    required String ?password,
    required String ?phone,
    required String ?uId,
    required String ?image,
    required String ?state,
    required String ?hair,
    required String ?face,
    required String ?body,
    required String ?description,
    required String ?location,
    required String ?stateWork,
    required int ?openOrClose,
    required int ?hoursStart,
    required int ?hoursEnd,
    required double ?ratting,
    required String ?uIdBody,
    required String ?uIdFace,
    required String ?uIdHair,
  }) {
    emit(UpdateOneSalonLoadingState());
    AddSalonModel model = AddSalonModel(
        name: name,
        email: email,
        password: password,
        phone: phone,
        uId: uId,
        image: image,
        state: state,
        body: body,
        face: face,
        hair: hair,
        description: description,
        location: location,
        stateWork: stateWork,
        hoursEnd: hoursEnd,
        hoursStart: hoursStart,
        openOrClose: openOrClose,
        ratting: ratting,
        uIdBody: uIdBody,
        uIdFace: uIdFace,
        uIdHair: uIdHair,
        token: token);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      emit(UpdateOneSalonSuccessState());
    }).catchError((error) {
      emit(UpdateOneSalonErrorState());
    });
  }

  List<AddSalonModel> salon = [];

  void getSalonData() {
    emit(ControlPanelCubitGetSalonLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .where('state', isEqualTo: 'salon')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        salon.add(AddSalonModel.fromJson(element.data()));
      });
      emit(ControlPanelGetSalonSuccessState());
    }).catchError(
          (error) {
        print(error.toString());
        emit(ControlPanelGetSalonErrorState());
      },
    );
  }

  //chat


  List<MessageModel> chatUser = [];

  List<String> chatUserNameSender = [];

  List<String> chatUserImageSender = [];

  List<String> chatUserUidSender = [];

  List<String> chatUserTokenSender = [];

  void getUserChat() {
    emit(ControlPanelGetUserChatLoadingState());
    FirebaseFirestore.instance
        .collection('chat')
        .doc(uId)
        .collection('messages')
        .where('receiverId', isEqualTo: uId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        chatUser.add(
          MessageModel.fromJson(
            element.data(),
          ),
        );
      });
      chatUser.forEach((element) {
        chatUserNameSender.add(element.nameSender!);
      });
      chatUser.forEach((element) {
        chatUserImageSender.add(element.imageSender!);
      });
      chatUser.forEach((element) {
        chatUserUidSender.add(element.senderId!);
      });
      chatUser.forEach((element) {
        chatUserTokenSender.add(element.senderToken!);
      });
      print(chatUserUidSender
          .toSet()
          .toList()
          .length);
      emit(ControlPanelGetUserChatSuccessState());
    }).catchError(
          (error) {
        print(error.toString());
        emit(ControlPanelGetUserChatErrorState());
      },
    );
  }


  void logOut(context) {
    cachHelper.removeData('uId');
    print(uId);
    NavegatandFinish(context, LoginScreen());
    emit(ControlPAnelCubitLogOutState());
  }


  //chat
  List<MessageModel> messages = [];

  void getMessage(receiveId) {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(receiveId)
        .collection('messages')
        .orderBy('dateTime')
        .where('roomId', isEqualTo: receiveId + uId.toString())
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(
          MessageModel.fromJson(
            element.data(),
          ),
        );
      });
      emit(ControlPanelCubitGetMessageSuccessState());
    });
  }

  void sendMessage({
    required String receiveId,
    required String dateTime,
    required String text,
    required String name,
    required String image,
    required String tokenReceiver,

  }) {
    MessageModel messageModel = MessageModel(
      dateTime: dateTime,
      receiverId: receiveId,
      senderId: uId,
      text: text,
      image: image,
      name: name,
      imageSender: model.image,
      nameSender: model.name,
      roomId: receiveId + uId.toString(),
      receiverToken: tokenReceiver,
      senderToken: token
    );
    FirebaseFirestore.instance
        .collection('chat')
        .doc(model.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(ControlPanelSendMessageSuccessState());
    }).catchError((error) {
      emit(ControlPanelSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('chat')
        .doc(receiveId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(ControlPanelSendMessageSuccessState());
      sendNotification(text,tokenReceiver);
    }).catchError((error) {
      emit(ControlPanelSendMessageErrorState());
    });
  }

  //notification


  sendNotification(String title, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=AAAAlS8dNQc:APA91bELaFaTNochPq8bKJdDAPInxyXVYJQ27PH1pbgXtna_mu6dpWtHPhKO3Z3bmjFvrU9lUh4ATBYaLAhYGxjlMyM2U708QAT63-TreuTAVxxstspsE5v-DW2xJlbdy5zrlAEpA-Is'
          },
          body: jsonEncode(<String, dynamic>{
            'notification': <String, dynamic>{
              'title': title,
              'body': 'wlc to app azyan',
              'sound':'default'
            },
            'priority': 'high',
            'data': data,
            'to': '$token'
          })
      );


      if (response.statusCode == 200) {
        print("Yeh notification is send");
      } else {
        print("Error");
      }
    } catch (e) {

    }
  }
}

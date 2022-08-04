import 'dart:convert';

import 'package:azyan/Layout/azyan_layout.dart';
import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/contol_panel/salon_dashboard/salon_dashboard_screen.dart';
import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/models/book_model.dart';
import 'package:azyan/models/message_model.dart';
import 'package:azyan/models/services_salon_model.dart';
import 'package:azyan/models/user_model.dart';
import 'package:azyan/modules/auth_screen/login_screen.dart';
import 'package:azyan/modules/chats/chat_screen.dart';
import 'package:azyan/modules/home/home_screen.dart';
import 'package:azyan/modules/account/my_account_screen.dart';
import 'package:azyan/modules/notification/notification_screen.dart';
import 'package:azyan/remote/cach_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


import 'states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppCubitInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel model = UserModel();

  void getUserData(context) {
    emit(AppCubitGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(AppCubitGetUserSuccessState(model));
      cachHelper.Savedataa(key: 'state', value: model.state)
          .then((value) {
        stateUser = cachHelper.getData('state');
        print('stateUser:$stateUser');
      });
      if (state is AppCubitGetUserSuccessState) {
        model.state == 'user'
            ? NavegatandFinish(context, AzyanLayout())
            : NavegatandFinish(context, SalonDashboardScreen());
      }
    }).catchError(
          (error) {
        print(
          error.toString(),
        );
        emit(
          AppCubitGetUserErrorState(error.toString()),
        );
      },
    );
  }

  int currentIndex = 0;
  List<Widget> screen = [
    Home(),
    NotificationScreen(),
    ChatScreen(),
    MyAccount(),
  ];
  List<String> titles = [
    'Home',
    'Notification',
    'Chat',
    'My Account',
  ];

  void onChangeScreen(int index) {
    currentIndex = index;
    emit(AppCubitChangeBottomNavigationState());
  }

  void logOut(context) {
    cachHelper.removeData('uId');
    print(uId);
    NavegatandFinish(context, LoginScreen());
    emit(AppCubitLogOutState());
  }

  List<AddSalonModel> salon = [];

  void getSalonData() {
    emit(AppCubitGetSalonLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .where('state', isEqualTo: 'salon')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        salon.add(AddSalonModel.fromJson(element.data()));
      });
      emit(AppCubitGetSalonSuccessState());
    }).catchError(
          (error) {
        print(error.toString());
        emit(AppCubitGetSalonErrorState());
      },
    );
  }

  // booking

  void changTimeBookingState() {
    emit(ChangTimeBookingState());
  }

  void changDateBookingState() {
    emit(ChangDateBookingState());
  }

  // void changDropDownServicesBooking() {emit(ChangDropDownServicesBookingState());}

  List servicesBooking = [];

  ModelSalonServicesHair modelSalonServicesHair = ModelSalonServicesHair();

  void getSalonServicesHairData(String uIdSalon, String uIdHAir) {
    emit(AppCubitGetSalonServicesHairDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uIdSalon)
        .collection('hair')
        .doc(uIdHAir)
        .get()
        .then((value) {
      modelSalonServicesHair = ModelSalonServicesHair.fromJson(value.data()!);
      if (modelSalonServicesHair.services1 == true) {
        servicesBooking.add('services 1');
      }
      if (modelSalonServicesHair.services2 == true) {
        servicesBooking.add('services 2');
      }
      if (modelSalonServicesHair.services3 == true) {
        servicesBooking.add('services 3');
      }
      if (modelSalonServicesHair.services4 == true) {
        servicesBooking.add('services 4');
      }
      if (modelSalonServicesHair.services5 == true) {
        servicesBooking.add('services 5');
      }
      if (modelSalonServicesHair.services6 == true) {
        servicesBooking.add('services 6');
      }
      if (modelSalonServicesHair.services7 == true) {
        servicesBooking.add('services 7');
      }
      if (modelSalonServicesHair.services1 == true) {
        servicesBooking.add('services 8');
      }
      print(servicesBooking);

      emit(AppCubitGetSalonServicesHairDataSuccessState());
    }).catchError(
          (error) {
        print(error.toString());

        emit(AppCubitGetSalonServicesHairDataErrorState());
      },
    );
  }

  ModelSalonServicesFace modelSalonServicesFace = ModelSalonServicesFace();

  void getSalonServicesFaceData(String uIdSalon, String uIdFace) {
    emit(AppCubitGetSalonServicesFaceDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uIdSalon)
        .collection('Face')
        .doc(uIdFace)
        .get()
        .then((value) {
      modelSalonServicesFace = ModelSalonServicesFace.fromJson(value.data()!);
      if (modelSalonServicesFace.services1 == true) {
        servicesBooking.add('services 1');
      }
      if (modelSalonServicesFace.services2 == true) {
        servicesBooking.add('services 2');
      }
      if (modelSalonServicesFace.services3 == true) {
        servicesBooking.add('services 3');
      }
      if (modelSalonServicesFace.services4 == true) {
        servicesBooking.add('services 4');
      }
      if (modelSalonServicesFace.services5 == true) {
        servicesBooking.add('services 5');
      }
      if (modelSalonServicesFace.services6 == true) {
        servicesBooking.add('services 6');
      }
      print(servicesBooking);

      emit(AppCubitGetSalonServicesFaceDataSuccessState());
    }).catchError(
          (error) {
        print(error.toString());

        emit(AppCubitGetSalonServicesFaceDataErrorState());
      },
    );
  }

  ModelSalonServicesBody modelSalonServicesBody = ModelSalonServicesBody();

  void getSalonServicesBodyData(String uIdSalon, String uIdBody) {
    emit(AppCubitGetSalonServicesBodyDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uIdSalon)
        .collection('Body')
        .doc(uIdBody)
        .get()
        .then((value) {
      modelSalonServicesBody = ModelSalonServicesBody.fromJson(value.data()!);
      if (modelSalonServicesBody.services1 == true) {
        servicesBooking.add('services 1');
      }
      if (modelSalonServicesBody.services2 == true) {
        servicesBooking.add('services 2');
      }
      if (modelSalonServicesBody.services3 == true) {
        servicesBooking.add('services 3');
      }
      if (modelSalonServicesBody.services4 == true) {
        servicesBooking.add('services 4');
      }
      if (modelSalonServicesBody.services5 == true) {
        servicesBooking.add('services 5');
      }
      print(servicesBooking);

      emit(AppCubitGetSalonServicesBodyDataSuccessState());
    }).catchError(
          (error) {
        print(error.toString());

        emit(AppCubitGetSalonServicesBodyDataErrorState());
      },
    );
  }

  List<bool>? isCheckedServices;

  Map<String, dynamic> checkboxResultServices = {};

  initState() {
    isCheckedServices = List<bool>.filled(servicesBooking.length, false);
  }

  void checkboxResultFunction(value, index) {
    emit(AppCubitFillCheckboxServicesStates());
    isCheckedServices![index] = value;
    checkboxResultServices.addEntries([
      MapEntry(
        servicesBooking[index],
        isCheckedServices![index],
      ),
    ]);
    for (int i = 0; i <= servicesBooking.length - 1; i++) {
      checkboxResultServices.addEntries([
        MapEntry(
          servicesBooking[i],
          isCheckedServices![i],
        ),
      ]);
    }
    print(checkboxResultServices);
  }

  void createBooking({
    required String uIdUser,
    required String uIdSalon,
    required String uIdBook,
    required String dateBook,
    required String timeBook,
    required String uIdServices,
    required String nameSalon,
  }) {
    BookModel bookModel = BookModel(
        dateBook: dateBook,
        timeBook: timeBook,
        uIdBook: uIdBook,
        uIdSalon: uIdSalon,
        uIdServices: uIdServices,
        uIdUser: uIdUser);
    FirebaseFirestore.instance
        .collection('Booking')
        .add(bookModel.toMap())
        .then(
          (value) {
        addBookSalonServices(
            uIdUser: uIdUser,
            uIdSalon: uIdSalon,
            uIdBook: value.id,
            uIdServices: uIdServices,
            timeBook: timeBook,
            dateBook: dateBook,
            servicesMap: checkboxResultServices,

        );
        emit(CreateBookingSuccessState());
      },
    ).catchError(
          (error) {
        emit(CreateBookingErrorState());
      },
    );
  }

  void addBookSalonServices({
    required Map<String, dynamic> servicesMap,
    required String uIdUser,
    required String uIdSalon,
    required String uIdBook,
    required String dateBook,
    required String timeBook,
    required String uIdServices,
  }) {
    FirebaseFirestore.instance
        .collection('Booking')
        .doc(uIdBook)
        .collection('Services Booking')
        .add(servicesMap)
        .then((value) {
      print(value.id);

      updateBooking(
        uIdUser: uIdUser,
        uIdSalon: uIdSalon,
        uIdBook: uIdBook,
        dateBook: dateBook,
        timeBook: timeBook,
        uIdServices: value.id,
      );
    }).catchError(
          (error) {},
    );
  }

  void updateBooking({
    required String uIdUser,
    required String uIdSalon,
    required String uIdBook,
    required String dateBook,
    required String timeBook,
    required String uIdServices,
  }) {
    emit(UpdateBookingLoadingState());
    BookModel bookModel = BookModel(
        dateBook: dateBook,
        timeBook: timeBook,
        uIdBook: uIdBook,
        uIdSalon: uIdSalon,
        uIdServices: uIdServices,
        uIdUser: uIdUser);
    FirebaseFirestore.instance
        .collection('Booking')
        .doc(uIdBook)
        .update(bookModel.toMap())
        .then((value) {
      emit(UpdateBookingSuccessState());
    }).catchError((error) {
      emit(UpdateBookingErrorState());
    });
  }

  //chat

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
      roomId: uId.toString() + receiveId,
      receiverToken: tokenReceiver,
      senderToken: token
    );
    FirebaseFirestore.instance
        .collection('chat')
        .doc(model.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('chat')
        .doc(receiveId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
      sendNotification(text,tokenReceiver);
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

  }

  List<MessageModel> messages = [];

  void getMessage({required String receiveId}) {
    FirebaseFirestore.instance
        .collection('chat')
        .doc(receiveId)
        .collection('messages')
        .orderBy('dateTime')
        .where('roomId', isEqualTo: uId.toString() + receiveId.toString())
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
      emit(GetMessageSuccessState());
    });
  }

  List<MessageModel> chatUser = [];

  List<String> chatUserName = [];

  List<String> chatUserImage = [];

  List<String> chatUserUid = [];

  void getUserChat() {
    emit(AppCubitGetUserChatLoadingState());
    FirebaseFirestore.instance
        .collection('chat')
        .doc(uId)
        .collection('messages')
        .where('senderId', isEqualTo: uId)
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
        chatUserName.add(element.name!);
      });
      chatUser.forEach((element) {
        chatUserImage.add(element.image!);
      });
      chatUser.forEach((element) {
        chatUserUid.add(element.receiverId!);
      });

      emit(AppCubitGetUserChatSuccessState());
    }).catchError(
          (error) {
        print(error.toString());
        emit(AppCubitGetUserChatErrorState());
      },
    );
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
              'body': 'You are followed by someone'
            },
            'priority': 'high',
            'data': data,
            'to': '$token'
          })
      );


      if (response.statusCode == 200) {
        print("Yeh notificatin is sended");
      } else {
        print("Error");
      }
    } catch (e) {

    }
  }





}
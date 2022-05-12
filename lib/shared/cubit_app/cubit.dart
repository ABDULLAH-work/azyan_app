import 'package:azyan/Layout/azyan_layout.dart';
import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/models/user_model.dart';
import 'package:azyan/modules/auth_screen/login_screen.dart';
import 'package:azyan/modules/chat_screen.dart';
import 'package:azyan/modules/home_screen.dart';
import 'package:azyan/modules/my_account_screen.dart';
import 'package:azyan/remote/cach_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppCubitInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel model = UserModel();

  void getUserData(context) {
    emit(AppCubitGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);

      // model.state == 'user'
      //     ? NavegatandFinish(context, AzyanLayout())
      //     : Navigator.pop(context);
      emit(AppCubitGetUserSuccessState(model));
      if (state is AppCubitGetUserSuccessState) {
        model.state == 'user'
            ? NavegatandFinish(context, AzyanLayout())
            : Navigator.pop(context);
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
    Home(),
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
}

import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/models/user_model.dart';
import 'package:azyan/modules/auth_screen/login_screen.dart';
import 'package:azyan/modules/home.dart';
import 'package:azyan/modules/salon_services_user.dart';
import 'package:azyan/remote/cach_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/chat_screen.dart';
import '../../modules/my_account_screen.dart';
import 'states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppCubitInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel model = UserModel();

  void getUserData() {
    emit(AppCubitGetUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(AppCubitGetUserSuccessState());
    }).catchError(
      (error) {
        print(error.toString());
        emit(AppCubitGetUserErrorState(error.toString()));
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


  void logOut(context ){
    cachHelper.removeData('uId');
    print(uId);
    NavegatandFinish(context, LoginScreen());
    emit(AppCubitLogOutState());
  }
}

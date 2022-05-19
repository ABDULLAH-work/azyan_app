import 'package:azyan/Layout/azyan_layout.dart';
import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/models/services_salon_model.dart';
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

  void changTimeBookingState() {
    emit(ChangTimeBookingState());
  }

  void changDateBookingState() {
    emit(ChangDateBookingState());
  }




  // void changDropDownServicesBooking() {emit(ChangDropDownServicesBookingState());}



  List servicesBooking = [];


  ModelSalonServicesHair modelSalonServicesHair=ModelSalonServicesHair();

  void getSalonServicesHairData(String  uIdSalon,String uIdHAir) {
     emit(AppCubitGetSalonServicesHairDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uIdSalon).collection('hair')
        .doc(uIdHAir).get().then((value) {
      modelSalonServicesHair = ModelSalonServicesHair.fromJson(value.data()!);
      print(modelSalonServicesHair.services1);
      if(modelSalonServicesHair.services1==true) {
        servicesBooking.add('services 1');
      } if(modelSalonServicesHair.services2==true) {
        servicesBooking.add('services 2');
      } if(modelSalonServicesHair.services3==true) {
        servicesBooking.add('services 3');
      } if(modelSalonServicesHair.services4==true) {
        servicesBooking.add('services 4');
      } if(modelSalonServicesHair.services5==true) {
        servicesBooking.add('services 5');
      } if(modelSalonServicesHair.services6==true) {
        servicesBooking.add('services 6');
      } if(modelSalonServicesHair.services7==true) {
        servicesBooking.add('services 7');
      } if(modelSalonServicesHair.services1==true) {
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



  ModelSalonServicesFace modelSalonServicesFace=ModelSalonServicesFace();

  void getSalonServicesFaceData(String  uIdSalon,String uIdFace) {
    emit(AppCubitGetSalonServicesFaceDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uIdSalon).collection('Face')
        .doc(uIdFace).get().then((value) {
      modelSalonServicesFace = ModelSalonServicesFace.fromJson(value.data()!);
      if(modelSalonServicesFace.services1==true) {
        servicesBooking.add('services 1');
      } if(modelSalonServicesFace.services2==true) {
        servicesBooking.add('services 2');
      } if(modelSalonServicesFace.services3==true) {
        servicesBooking.add('services 3');
      } if(modelSalonServicesFace.services4==true) {
        servicesBooking.add('services 4');
      } if(modelSalonServicesFace.services5==true) {
        servicesBooking.add('services 5');
      } if(modelSalonServicesFace.services6==true) {
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


  ModelSalonServicesBody modelSalonServicesBody=ModelSalonServicesBody();

  void getSalonServicesBodyData(String  uIdSalon,String uIdBody) {
    emit(AppCubitGetSalonServicesBodyDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uIdSalon).collection('Body')
        .doc(uIdBody).get().then((value) {
      modelSalonServicesBody = ModelSalonServicesBody.fromJson(value.data()!);
      if(modelSalonServicesBody.services1==true) {
        servicesBooking.add('services 1');
      } if(modelSalonServicesBody.services2==true) {
        servicesBooking.add('services 2');
      } if(modelSalonServicesBody.services3==true) {
        servicesBooking.add('services 3');
      } if(modelSalonServicesBody.services4==true) {
        servicesBooking.add('services 4');
      } if(modelSalonServicesBody.services5==true) {
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
    emit(AddSalonFillCheckboxServicesStates());
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



}
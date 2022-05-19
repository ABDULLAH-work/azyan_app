import 'package:azyan/models/user_model.dart';

abstract class AppState {}

class AppCubitInitialState extends AppState {}

class AppCubitGetUserLoadingState extends AppState {}

class AppCubitGetUserSuccessState extends AppState {
  final UserModel model;

  AppCubitGetUserSuccessState(this.model);
}

class AppCubitGetUserErrorState extends AppState {
  final String error;

  AppCubitGetUserErrorState(this.error);
}

class AppCubitChangeBottomNavigationState extends AppState {}

class AppCubitLogOutState extends AppState {}

class AppCubitGetSalonLoadingState extends AppState {}

class AppCubitGetSalonSuccessState extends AppState {}

class AppCubitGetSalonErrorState extends AppState {}


class ChangDropDownServicesBookingState extends AppState {}

class ChangTimeBookingState extends AppState {}

class ChangDateBookingState extends AppState {}


class AppCubitGetSalonServicesHairDataLoadingState extends AppState {}

class AppCubitGetSalonServicesHairDataSuccessState extends AppState {}

class AppCubitGetSalonServicesHairDataErrorState extends AppState {}

class AppCubitGetSalonServicesFaceDataLoadingState extends AppState {}

class AppCubitGetSalonServicesFaceDataSuccessState extends AppState {}

class AppCubitGetSalonServicesFaceDataErrorState extends AppState {}

class AppCubitGetSalonServicesBodyDataLoadingState extends AppState {}

class AppCubitGetSalonServicesBodyDataSuccessState extends AppState {}

class AppCubitGetSalonServicesBodyDataErrorState extends AppState {}

class AddSalonFillCheckboxServicesStates extends AppState {}
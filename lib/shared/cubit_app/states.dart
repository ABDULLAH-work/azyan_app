abstract class AppState {}

class AppCubitInitialState extends AppState {}

class AppCubitGetUserLoadingState extends AppState {}

class AppCubitGetUserSuccessState extends AppState {}

class AppCubitGetUserErrorState extends AppState {
  final String error;

  AppCubitGetUserErrorState(this.error);
}

class AppCubitChangeBottomNavigationState extends AppState {}

class AppCubitLogOutState extends AppState {}

class AppCubitGetSalonLoadingState extends AppState {}

class AppCubitGetSalonSuccessState extends AppState {}

class AppCubitGetSalonErrorState extends AppState {}

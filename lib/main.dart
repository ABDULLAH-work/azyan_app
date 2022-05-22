import 'package:azyan/Layout/azyan_layout.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/modules/on_bording_screen.dart';
import 'package:azyan/modules/salon_or_services_or_user_screen.dart';
import 'package:azyan/shared/add_salon_cubit/cubit.dart';
import 'package:azyan/shared/cotrol_panel_cubit/cubit.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/login_cubit/cubit.dart';
import 'package:azyan/shared/simple_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:azyan/remote/cach_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'shared/register_cubit/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await cachHelper.init();
  dynamic onBoardingFinish = false;
  onBoardingFinish = cachHelper.getData('ShowOnBoard');

  late Widget start;
  uId = cachHelper.getData('uId');

  print(uId);
  if (onBoardingFinish != null) {
    if (uId == null) {
      start = SalonOrServicesOrUser();
    } else {
      start = AzyanLayout();
    }
  } else {
    start = OnBording_Screen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(start));
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget startApp;

  MyApp(this.startApp);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit()..getUserData(context)..getSalonData()..getUserChat(),
        ),
        BlocProvider(
          create: (context) => AddSalonCubit()..initState(),
        ),
        BlocProvider(
          create: (context) => ControlPanelCubit()..getSalonData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Azyan',
        theme: ThemeData(
          fontFamily: 'IBM',
          buttonTheme: ButtonThemeData(buttonColor: HexColor('#EB4043')),
          scaffoldBackgroundColor: HexColor("#FFEBED"),
          appBarTheme:AppBarTheme(backgroundColor:HexColor("#FFEBED"), ),
          primarySwatch: Colors.red,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: HexColor("#FFEBED"),
          ),
        ),
        home: startApp,
      ),
    );
  }
}

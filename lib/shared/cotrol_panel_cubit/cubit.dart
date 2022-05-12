import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/shared/cotrol_panel_cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlPanelCubit extends Cubit<ControlPanelStates> {
  ControlPanelCubit() : super(ControlPanelInitialState());

  static ControlPanelCubit get(context) => BlocProvider.of(context);

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
}

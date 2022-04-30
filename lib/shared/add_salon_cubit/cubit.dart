import 'dart:io';
import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/shared/add_salon_cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddSalonCubit extends Cubit<AddSalonStates> {
  AddSalonCubit() : super(AddSalonStatesInitialState());

  static AddSalonCubit get(context) => BlocProvider.of(context);

  IconData iconData = Icons.visibility_outlined;

  bool isoscureShow = true;

  void eyeisShow() {
    iconData = isoscureShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    isoscureShow = !isoscureShow;
    emit(AddSalonShowPasswordStates());
  }

  List<String> servicesHair = [
    "services 1",
    "services 2",
    "services 3",
    "services 4",
    "services 5",
    "services 6",
    "services 7",
    "services 8",
  ];
  List<String> servicesFace = [
    "services 1",
    "services 2",
    "services 3",
    "services 4",
    "services 5",
    "services 6",
  ];
  List<String> servicesBody = [
    "services 1",
    "services 2",
    "services 3",
    "services 4",
    "services 5",
  ];

  List<bool>? isCheckedHair;
  List<bool>? isCheckedBody;
  List<bool>? isCheckedFace;

  Map<String, dynamic> checkboxResultHair = {};
  Map<String, dynamic> checkboxResultFace = {};
  Map<String, dynamic> checkboxResultBody = {};

  initState() {
    isCheckedHair = List<bool>.filled(servicesHair.length, false);
    isCheckedFace = List<bool>.filled(servicesFace.length, false);
    isCheckedBody = List<bool>.filled(servicesBody.length, false);
  }

  void checkboxResultHairFunction(value, index) {
    emit(AddSalonFillCheckboxServicesHairStates());
    isCheckedHair![index] = value;
    checkboxResultHair.addEntries([
      MapEntry(
        servicesHair[index],
        isCheckedHair![index],
      ),
    ]);
    for (int i = 0; i <= servicesHair.length - 1; i++) {
      checkboxResultHair.addEntries([
        MapEntry(
          servicesHair[i],
          isCheckedHair![i],
        ),
      ]);
    }
    print(checkboxResultHair);
  }

  void checkboxResultFaceFunction(value, index) {
    emit(AddSalonFillCheckboxServicesFaceStates());
    isCheckedFace![index] = value;
    checkboxResultFace.addEntries([
      MapEntry(
        servicesFace[index],
        isCheckedFace![index],
      ),
    ]);
    for (int i = 0; i <= servicesFace.length - 1; i++) {
      checkboxResultFace.addEntries([
        MapEntry(
          servicesFace[i],
          isCheckedFace![i],
        ),
      ]);
    }
    print(checkboxResultHair);
  }

  void checkboxResultBodyFunction(value, index) {
    emit(AddSalonFillCheckboxServicesBodyStates());
    isCheckedBody![index] = value;
    checkboxResultBody.addEntries([
      MapEntry(
        servicesBody[index],
        isCheckedBody![index],
      ),
    ]);
    for (int i = 0; i <= servicesBody.length - 1; i++) {
      checkboxResultBody.addEntries([
        MapEntry(
          servicesBody[i],
          isCheckedBody![i],
        ),
      ]);
    }
    print(checkboxResultBody);
  }

  File? salonImage;

  final picker = ImagePicker();

  Future getSalonImage() async {
    final pikedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pikedFile != null) {
      salonImage = File(pikedFile.path);
      emit(AddSalonImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(AddSalonImagePickedErrorState());
    }
  }

  String salonImageUrl = '';

  void uploadSalonImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'salon/${Uri.file(salonImage!.path).pathSegments.last}',
        )
        .putFile(salonImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        salonImageUrl = value;
        emit(AddSalonUploadImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(AddSalonUploadImageErrorState());
        print(error.toString());
        print('error 1');
      });
    }).catchError((error) {
      emit(AddSalonUploadImageErrorState());
      print('error 2');
    });
  }




  void salonRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
    required String state,
    required String hair,
    required String face,
    required String body,
  }) {
    emit(SalonRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        salonCreate(
          name: name,
          email: email,
          phone: phone,
          password: password,
          uId: value.user!.uid,
          image: image,
          state: state,
          hair: hair,
          face: face,
          body: body,
        );
      },
    ).catchError(
      (error) {
        print(error);
        emit(SalonRegisterErrorState());
      },
    );
  }

  void salonCreate({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uId,
    required String image,
    required String state,
    required String hair,
    required String face,
    required String body,
  }) {
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
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then(
      (value) {
        emit(RegisterCreateSalonSuccessState(uId));
      },
    ).catchError(
      (error) {
        emit(RegisterCreateSalonErrorState());
      },
    );
  }
}

import 'package:azyan/constance/component.dart';
import 'package:azyan/contol_panel/management_salon_screen.dart';
import 'package:azyan/shared/add_salon_cubit/cubit.dart';
import 'package:azyan/shared/add_salon_cubit/states.dart';
import 'package:azyan/shared/cotrol_panel_cubit/cubit.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class AddSalonServices extends StatelessWidget {
  String name;
  String email;
  String password;
  String phone;
  String description;
  String location;
  int hoursStart;
  int hoursEnd;


  AddSalonServices(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.description,
      required this.location,
      required this.hoursStart,
      required this.hoursEnd,

      });

  Widget build(BuildContext context) {
    bool checkedHair = false;
    bool checkedFace = false;
    bool checkedBody = false;
    return BlocConsumer<AddSalonCubit, AddSalonStates>(
      listener: (context, state) {
        if (state is AddSalonUploadImageSuccessState) {
          AddSalonCubit.get(context).salonRegister(
            name: name,
            email: email,
            password: password,
            phone: phone,
            image: AddSalonCubit.get(context).salonImageUrl,
            state: 'salon',
            hair: checkedHair ? 'true' : 'false',
            face: checkedFace ? 'true' : 'false',
            body: checkedBody ? 'true' : 'false',
            description: description,
            location: location,
            stateWork:  'work',
            hoursEnd: hoursEnd,
            hoursStart: hoursStart,
            openOrClose: 1,
            ratting:  3.5,
            uIdHair: 'null',uIdFace: 'null',uIdBody: 'null'
          );

        }
        if (state is RegisterCreateSalonSuccessState) {
          ControlPanelCubit.get(context).salon.clear();
          ControlPanelCubit.get(context).getSalonData();

          NavegatandFinish(
            context,
            ManagementSalonScreen(),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.grey),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: const Text(
              "services",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.red,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hair",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.red,
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: AddSalonCubit.get(context).servicesHair.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                              AddSalonCubit.get(context).servicesHair[index]),
                          value:
                              AddSalonCubit.get(context).isCheckedHair![index],
                          onChanged: (value) {
                            AddSalonCubit.get(context)
                                .checkboxResultHairFunction(value, index);
                            checkedHair = true;
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Face",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.red,
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: AddSalonCubit.get(context).servicesFace.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                              AddSalonCubit.get(context).servicesFace[index]),
                          value:
                              AddSalonCubit.get(context).isCheckedFace![index],
                          onChanged: (value) {
                            AddSalonCubit.get(context)
                                .checkboxResultFaceFunction(value, index);
                            checkedFace = true;
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Body",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.red,
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: AddSalonCubit.get(context).servicesBody.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                              AddSalonCubit.get(context).servicesBody[index]),
                          value:
                              AddSalonCubit.get(context).isCheckedBody![index],
                          onChanged: (value) {
                            AddSalonCubit.get(context)
                                .checkboxResultBodyFunction(value, index);
                            checkedBody = true;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bottom(
                          borderColor: Colors.red,
                          width: MediaQuery.of(context).size.width / 3,
                          height: 30,
                          color: HexColor('#EB4043'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'Back',
                          Colortext: Colors.white,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),if(state is SalonRegisterLoadingState)
                          Center(child: CircularProgressIndicator())
                        else
                        bottom(
                          borderColor: Colors.red,
                          width: MediaQuery.of(context).size.width / 3,
                          height: 30,
                          color: HexColor('#EB4043'),
                          onPressed: () {
                            AddSalonCubit.get(context).uploadSalonImage();
                          },
                          text: 'Add',
                          Colortext: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

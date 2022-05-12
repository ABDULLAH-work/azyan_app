import 'package:azyan/constance/component.dart';
import 'package:azyan/contol_panel/add_salon/add_salon_services_screen.dart';
import 'package:azyan/remote/cach_helper.dart';
import 'package:azyan/shared/add_salon_cubit/cubit.dart';
import 'package:azyan/shared/add_salon_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class AddSalonScreen extends StatelessWidget {
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddSalonCubit, AddSalonStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = AddSalonCubit.get(context);
        var salonImage = AddSalonCubit.get(context).salonImage;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                )),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Add Salon',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30.0,
                            color: HexColor('#EB4043'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 50.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40.0,
                                backgroundImage: salonImage == null
                                    ? NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Person_icon_BLACK-01.svg/1200px-Person_icon_BLACK-01.svg.png',
                                      )
                                    : FileImage(salonImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              color: Colors.red,
                              onPressed: () {
                                cubit.getSalonImage();
                              },
                              icon: CircleAvatar(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      defulteditTextx(
                        Controlar: nameController,
                        keyboardType: TextInputType.text,
                        Lable: 'User Name',
                        // prefix: Icons.person,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter your Name';
                          }
                          return null;
                        },
                        hint: 'Enter your user name',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defulteditTextx(
                        Controlar: emailController,
                        keyboardType: TextInputType.text,
                        Lable: 'Email',
                        //prefix: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter your Email';
                          }
                          return null;
                        },
                        hint: 'Enter your email',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defulteditTextx(
                        Controlar: passwordController,
                        keyboardType: TextInputType.text,
                        Lable: 'Password',
                        //prefix: Icons.lock,
                        sufix: cubit.iconData,
                        obscureText: cubit.isoscureShow,
                        suffixPressed: () {
                          cubit.eyeisShow();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter your Password';
                          }
                          return null;
                        },
                        onfiled: (value) {
                          print(value);
                        },
                        // onSubmit: (value) {
                        //   if (Formkey.currentState!.validate()) {
                        //     cubit.userRegister(
                        //       email: EmailConerolar.text,
                        //       password: PasswordConerolar.text,
                        //       name: NamedConerolar.text,
                        //       phone: PhoneConerolar.text,
                        //       location: cubit.selectedLocation,
                        //       status: cubit.selectStatus,
                        //
                        //     );
                        //   }
                        // },
                        hint: 'Enter your password',
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defulteditTextx(
                        Controlar: phoneController,
                        keyboardType: TextInputType.phone,
                        Lable: 'Phone Number',
                        //prefix: Icons.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter your Phone';
                          }
                          return null;
                        },
                        hint: '+971',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Description',
                          hintText: 'Enter details about salon',
                          hintStyle: TextStyle(fontSize: 11.5),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Colors.red,
                          ),
                        ),
                        controller: descriptionController,
                        minLines: 4,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Location',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue[100],
                                ),
                                height: 22,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined),
                                  iconEnabledColor: HexColor('#ff5555'),
                                  hint: const Text('                       '),
                                  // Not necessary for Option 1
                                  value: cubit.selectedLocation,
                                  onChanged: (newValue) {
                                    cubit.selectedLocation =
                                        newValue.toString();
                                    cubit.changDropDownLocation();
                                  },
                                  items: cubit.locations.map((location) {
                                    return DropdownMenuItem(
                                      child: Text(location),
                                      value: location,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 13,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Time Start',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue[100],
                                ),
                                height: 22,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined),
                                  iconEnabledColor: HexColor('#ff5555'),
                                  hint: Text('            '),
                                  // Not necessary for Option 1
                                  value: cubit.selectedTimeStart,
                                  onChanged: (newValue) {
                                    cubit.selectedTimeStart =
                                        int.tryParse(newValue.toString());
                                    cubit.changDropDownTimeStart();
                                  },
                                  items: cubit.timeStart.map((timeStart) {
                                    return DropdownMenuItem(
                                      child: Text(timeStart.toString()),
                                      value: timeStart,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 13,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Time End',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue[100],
                                ),
                                height: 22,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined),
                                  iconEnabledColor: HexColor('#ff5555'),
                                  hint: Text('            '),
                                  // Not necessary for Option 1
                                  value: cubit.selectedTimeEnd,
                                  onChanged: (newValue) {
                                    cubit.selectedTimeEnd =
                                        int.tryParse(newValue.toString());
                                    cubit.changDropDownTimeEnd();
                                  },
                                  items: cubit.timeEnd.map((timeEnd) {
                                    return DropdownMenuItem(
                                      child: Text(timeEnd.toString()),
                                      value: timeEnd,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Center(
                        child: bottom(
                          borderColor: Colors.red,
                          width: MediaQuery.of(context).size.width / 3,
                          height: 30,
                          color: HexColor('#EB4043'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (salonImage != null) {
                                //AddSalonCubit.get(context).uploadSalonImage();
                                PushToNextScreen(
                                  context,
                                  AddSalonServices(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    description: descriptionController.text,
                                    location: cubit.selectedLocation!,
                                    hoursStart: cubit.selectedTimeStart!,
                                    hoursEnd: cubit.selectedTimeEnd!,
                                  ),
                                );
                              } else {
                                showToast('please check your image ');
                              }
                            }
                          },
                          text: 'Next',
                          Colortext: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

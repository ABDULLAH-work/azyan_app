import 'package:azyan/Layout/azyan_layout.dart';
import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/modules/auth_screen/login_screen.dart';
import 'package:azyan/remote/cach_helper.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/register_cubit/cubit.dart';
import 'package:azyan/shared/register_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterScreen extends StatelessWidget {
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (BuildContext context, state) {
        if (state is RegisterCreateUserSuccessState) {
          cachHelper.Savedataa(key: 'uId', value: state.Uid).then((value) {
            uId = cachHelper.getData('uId');
            AppCubit.get(context).getUserData();
            NavegatandFinish(context, AzyanLayout());
          });
        }
        if (state is RegisterUploadImageSuccessState) {
          RegisterCubit.get(context).userRegister(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            phone: phoneController.text,
            location: RegisterCubit.get(context).selectedLocation.toString(),
            status: RegisterCubit.get(context).selectStatus.toString(),
            image: RegisterCubit.get(context).profileImageUrl,
            state:'user'
          );
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = RegisterCubit.get(context);
        var profileImage = RegisterCubit.get(context).profileImage;
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
                          'Signup',
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
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Person_icon_BLACK-01.svg/1200px-Person_icon_BLACK-01.svg.png',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              color: Colors.red,
                              onPressed: () {
                                cubit.getProfileImage();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.blue[100],
                                ),
                                height: 22,
                                child: DropdownButton(
                                  icon:
                                      Icon(Icons.keyboard_arrow_down_outlined),
                                  iconEnabledColor: HexColor('#ff5555'),
                                  hint: Text('                          '),
                                  // Not necessary for Option 1
                                  value: cubit.selectedLocation,
                                  onChanged: (newValue) {
                                    cubit.selectedLocation =
                                        newValue.toString();
                                    cubit.changDropDownLocation(
                                        newValue.toString());
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
                            width: MediaQuery.of(context).size.width / 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status',
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
                                  icon:
                                      Icon(Icons.keyboard_arrow_down_outlined),
                                  iconEnabledColor: HexColor('#ff5555'),
                                  hint: Text('                         '),
                                  // Not necessary for Option 1
                                  value: cubit.selectStatus,
                                  onChanged: (newValue) {
                                    cubit.selectStatus = newValue.toString();
                                    cubit.changDropDownStatus(
                                        newValue.toString());
                                  },
                                  items: cubit.status.map((location) {
                                    return DropdownMenuItem(
                                      child: Text(location),
                                      value: location,
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
                        child: state != RegisterLoadingState
                            ? bottom(
                          borderColor: Colors.red,
                                width: MediaQuery.of(context).size.width / 3,
                                height: 30,
                                color: HexColor('#EB4043'),
                                onPressed: () {
                                  if (cubit.selectedLocation == null
                                    ) {
                                    showToast(
                                        'please check your location ');
                                  }else if(  cubit.selectStatus == null)
                                  {
                                    showToast(
                                        'please check your status ');
                                  }
                                  else if (formKey.currentState!.validate()) {
                                    if (profileImage != null) {
                                      cubit.uploadProfileImage();
                                    } else {
                                      showToast('please check your image ');
                                    }
                                  }
                                },
                                text: 'Get Start',
                                Colortext: Colors.white,
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account yet ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              PushToNextScreen(context, LoginScreen());
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ],
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

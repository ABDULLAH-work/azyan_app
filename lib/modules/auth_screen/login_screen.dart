import 'package:azyan/Layout/azyan_layout.dart';
import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/contol_panel/admin_screen.dart';
import 'package:azyan/modules/auth_screen/register_screen.dart';
import 'package:azyan/remote/cach_helper.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/login_cubit/cubit.dart';
import 'package:azyan/shared/login_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showToast('Login Error');
        }

        if (state is LoginSuccessState) {
          cachHelper.Savedataa(key: 'uId', value: state.Uid).then((value) {
            uId = cachHelper.getData('uId');
            print(uId);
            AppCubit.get(context).getUserData();
            NavegatandFinish(context, AzyanLayout());
          });
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'AZYAN',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            defulteditTextx(
                              Controlar: emailController,
                              keyboardType: TextInputType.emailAddress,
                              Lable: 'Email Address',
                              hint: 'Enter yor email or user name',
                              prefix: Icons.email,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is to Short';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            defulteditTextx(
                              Controlar: passwordController,
                              keyboardType: TextInputType.text,
                              Lable: 'Password',
                              hint: 'Enter your password',
                              prefix: Icons.lock,
                              sufix: cubit.iconData,
                              obscureText: cubit.isoscureShow,
                              suffixPressed: () {
                                cubit.eyeisShow();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is to Short';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },
                              onSubmit: (value) {
                                if (emailController.text == 'admin' &&
                                    passwordController.text == 'admin') {
                                  PushToNextScreen(context, AdminScreen());
                                } else if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (BuildContext context) => Center(
                                child: bottom(
                                  borderColor: Colors.red,
                                  Colortext: HexColor('#ff5555'),
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  color: Colors.white.withOpacity(0),
                                  onPressed: () {
                                    if (emailController.text == 'admin' &&
                                        passwordController.text == 'admin') {
                                      PushToNextScreen(context, AdminScreen());
                                    } else if (formKey.currentState!
                                        .validate()) {
                                      cubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'Login',
                                ),
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t Have an account yet ?',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    PushToNextScreen(context, RegisterScreen());
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

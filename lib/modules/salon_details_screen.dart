import 'package:azyan/constance/component.dart';
import 'package:azyan/constance/constants.dart';
import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/cubit_app/states.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class SalonDetailsScreen extends StatefulWidget {
  final AddSalonModel model;

  SalonDetailsScreen(this.model);

  @override
  State<SalonDetailsScreen> createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {

  @override
  void initState() {
    AppCubit
        .get(context)
        .servicesBooking
        .clear();
    AppCubit.get(context).getSalonServicesHairData(
        widget.model.uId.toString(), widget.model.uIdHair.toString());
    AppCubit.get(context).getSalonServicesFaceData(
        widget.model.uId.toString(), widget.model.uIdFace.toString());
    AppCubit.get(context).getSalonServicesBodyData(
        widget.model.uId.toString(), widget.model.uIdBody.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    int current_mon = DateTime
        .now()
        .month;
   late String bookMonth;
    DateTime? bookMonthDisplay = DateTime.now();
    TimeOfDay bookHours = TimeOfDay(hour: widget.model.hoursStart!, minute: 0);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.grey),
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 90.0,
                      backgroundImage: NetworkImage('${widget.model.image}'),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    '${widget.model.name}',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.grey,
                          ),
                          Text(
                            '4.5',
                            style:
                            TextStyle(fontSize: 10.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      bottom(
                        borderColor: Colors.red,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 4,
                        height: 30,
                        color: HexColor('#EB4043'),
                        onPressed: () {},
                        text: 'Chat',
                        Colortext: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'About us',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5),
                      child: Text(
                        '${widget.model.description}',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.black54,
                    height: 1,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointment',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${months[current_mon - 1]} ${DateTime
                            .now()
                            .year}',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      customBottom(
                        borderColor: Colors.grey,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 8,
                        height: 50,
                        color: Colors.grey[100]!,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2050-12-31'),
                          ).then((value) {
                            bookMonth = DateFormat.yMMMd().format(value!);
                            bookMonthDisplay = value;
                            AppCubit.get(context).changDateBookingState();
                            print(bookMonth);
                          });
                        },
                        widget: Column(
                          children: [
                            Text(
                              bookMonthDisplay!.month.toString(),
                              style: TextStyle(color: Colors.red),
                            ),
                            Divider(
                              height: 1,
                            ),
                            Text(
                              bookMonthDisplay!.day.toString(),
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        Colortext: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      customBottom(
                        borderColor: Colors.red,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 8,
                        height: 50,
                        color: Colors.red,
                        onPressed: () {
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: TimeOfDay(
                                  hour: widget.model.hoursStart!, minute: 10),
                              onChange: (value) {
                                bookHours = value;
                                AppCubit.get(context).changTimeBookingState();
                                print(
                                    '${value.hour.toString()}:${value.minute}');
                              },
                              is24HrFormat: true,
                              maxHour: widget.model.hoursEnd!.toDouble() - 1,
                              minHour: widget.model.hoursStart!.toDouble(),
                              minMinute: 0.0,
                            ),
                          );
                        },
                        widget: Column(
                          children: [
                            Text(
                              '${bookHours.hour}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Divider(
                              height: 1,
                            ),
                            Text(
                              '${bookHours.minute}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Colortext: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      customBottom(
                        borderColor: Colors.red,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.95,
                        height: 50,
                        color: Colors.red,
                        onPressed: () {
                          AppCubit.get(context).initState();
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  StatefulBuilder(
                                    builder: (context, setState) =>
                                        AlertDialog(
                                          content: Column(
                                            children: [
                                              SizedBox(
                                                width: double.maxFinite,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: AppCubit
                                                      .get(context)
                                                      .servicesBooking
                                                      .length,
                                                  itemBuilder: (context,
                                                      index) {
                                                    return CheckboxListTile(
                                                      title: Text(AppCubit
                                                          .get(context)
                                                          .servicesBooking[index]),
                                                      value: AppCubit
                                                          .get(context)
                                                          .isCheckedServices![index],
                                                      onChanged: (value) {
                                                        AppCubit.get(context)
                                                            .checkboxResultFunction(
                                                            value, index);
                                                        setState(() {

                                                        });
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Align(
                                                alignment: Alignment
                                                    .bottomRight,
                                                child: customBottom(
                                                  borderColor: Colors.red,
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width / 4.7,
                                                  height: 30,
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    print(AppCubit
                                                        .get(context)
                                                        .checkboxResultServices);
                                                  },
                                                  widget: Center(
                                                    child: Text(
                                                      'ok',
                                                      style:
                                                      TextStyle(fontSize: 12.0,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Colortext: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ));
                        },
                        widget: Row(
                          children: [
                            Text(
                              '  Select Your Services',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Colortext: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      customBottom(
                        borderColor: Colors.red,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 4.7,
                        height: 50,
                        color: Colors.red,
                        onPressed: () {
                          AppCubit.get(context).createBooking(uIdUser: uId,
                              uIdSalon
                                  : widget.model.uId!,
                              uIdBook: 'null',
                              dateBook: bookMonth,
                              timeBook: '${bookHours.hour}:${bookHours.minute}',
                              uIdServices: 'null');
                        },
                        widget: Center(
                          child: Text(
                            'Booking',
                            style:
                            TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                        ),
                        Colortext: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
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

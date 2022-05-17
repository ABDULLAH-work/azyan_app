import 'package:azyan/constance/component.dart';
import 'package:azyan/models/add_salon_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SalonDetailsScreen extends StatelessWidget {
  final AddSalonModel model;

  SalonDetailsScreen(this.model);

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
    int current_mon = DateTime.now().month;

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
                  backgroundImage: NetworkImage('${model.image}'),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '${model.name}',
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
                        style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  bottom(
                    borderColor: Colors.red,
                    width: MediaQuery.of(context).size.width / 4,
                    height: 30,
                    color: HexColor('#EB4043'),
                    onPressed: () {},
                    text: 'Chat',
                    Colortext: Colors.white,
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                  child: Text(
                    '${model.description}',
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
                    '${months[current_mon - 1]} ${DateTime.now().year}',
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
                    width: MediaQuery.of(context).size.width / 8,
                    height: 50,
                    color: Colors.grey[100]!,
                    onPressed: () {},
                    widget: Column(
                      children: [
                        Text(
                          'Mon',
                          style: TextStyle(color: Colors.red),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Text(
                          'Mon',
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
                    width: MediaQuery.of(context).size.width / 8,
                    height: 50,
                    color: Colors.red,
                    onPressed: () {},
                    widget: Column(
                      children: [
                        Text(
                          'Mon',
                          style: TextStyle(color: Colors.white),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Text(
                          'Mon',
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
                    width: MediaQuery.of(context).size.width / 2.95,
                    height: 50,
                    color: Colors.red,
                    onPressed: () {},
                    widget: Row(
                      children: [
                        Text(
                          '  Select Your Services',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
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
                    width: MediaQuery.of(context).size.width / 4.7,
                    height: 50,
                    color: Colors.red,
                    onPressed: () {},
                    widget: Center(
                      child: Text(
                        'Booking',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
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
  }
}

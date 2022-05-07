import 'package:flutter/material.dart';

class ManagementSalonScreen extends StatelessWidget {
  const ManagementSalonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          'Management Salon',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: buildSalonItem(),
    );
  }

  Widget buildSalonItem() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      "https://cdn4.vectorstock.com/i/1000x1000/97/33/beautiful-women-face-hair-salon-logo-vector-27669733.jpg"),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Name Salon',
                  style: TextStyle(),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
          );
        },
        itemCount: 10);
  }
}

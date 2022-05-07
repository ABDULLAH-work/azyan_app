import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/cubit_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementSalonScreen extends StatelessWidget {
  const ManagementSalonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
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
            body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildSalonItem(AppCubit.get(context).salon[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                  );
                },
                itemCount: AppCubit.get(context).salon.length));
      },
      listener: (context, state) {},
    );
  }

  Widget buildSalonItem(AddSalonModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                "${model.image}"),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            '${model.name}',
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}

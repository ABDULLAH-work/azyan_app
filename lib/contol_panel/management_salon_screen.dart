import 'package:azyan/models/add_salon_model.dart';
import 'package:azyan/shared/cotrol_panel_cubit/cubit.dart';
import 'package:azyan/shared/cotrol_panel_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagementSalonScreen extends StatelessWidget {
  const ManagementSalonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlPanelCubit, ControlPanelStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.grey),
            title: const Text(
              'Management Salon',
              style: TextStyle(color: Colors.red),
            ),
            elevation: 0.0,
            centerTitle: true,
          ),
          body: state is! ControlPanelCubitGetSalonLoadingState
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildSalonItem(ControlPanelCubit.get(context).salon[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemCount: ControlPanelCubit.get(context).salon.length)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
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
            backgroundImage: NetworkImage("${model.image}"),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            '${model.name}',
          ),
        ],
      ),
    );
  }
}

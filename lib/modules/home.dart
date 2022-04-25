import 'package:azyan/shared/cubit_app/cubit.dart';
import 'package:azyan/shared/cubit_app/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).model;
        return cubit.email != null
            ? Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 20.0, bottom: 20.0, end: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello  ${cubit.name} ...',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(15.0),
                          width: double.infinity,
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.blue[100],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lets find your speclist',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                ' Skin care experts',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.blue[80],
                                  suffixIcon: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.red,
                                    ),
                                    //color: Colors.red,
                                    child:const Icon(
                                      Icons.search,
                                      size: 40.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'Category',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                              fontSize: 25.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        buildCategory(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Available',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            buildSalon(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildCategory() {
    return Container(
      width: double.infinity,
      height: 100,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(

            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.red,
                    ),
                    child: Icon(
                      Icons.face_retouching_natural,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  Text('Hair Care   '),
                ],
              ),
              SizedBox(width: 20),
              Container(
                width: 2,
                height: 77.0,
                color: Colors.red,
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 10);
        },
        itemCount: 10,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildSalon() {
    return SizedBox(
      //width: double.infinity,
      height: 180.0,
      child: ListView.separated(
        shrinkWrap: true,

        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: ()
            {

            },
            child: Stack(
              children: [
                Column(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.blue[100],
                      ),
                      width: 100.0,
                      height: 175.0,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        width: 84.0,
                        height: 90.0,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://media.istockphoto.com/photos/retro-styled-beauty-salon-picture-id1325440885?b=1&k=20&m=1325440885&s=170667a&w=0&h=JeC0ZLjDksr5rYOjnMevc0ZutvkNH_XmNJ9ZniyVKIY='),
                      ),
                    ),
                    Text(
                      'Dr.Lizza',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600),
                    ),
                     Text(
                      'Makeup artist',
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.amber,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.amber,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.amber,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.amber,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.white,
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 10);
        },
        itemCount: 10,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

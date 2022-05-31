import 'package:azyan/constance/component.dart';
import 'package:azyan/modules/salon_or_services_or_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/on_bordind_model.dart';
import '../auth_screen/login_screen.dart';
import 'package:azyan/remote/cach_helper.dart';

List<onbordModel> screens = [
  onbordModel(
      title: 'Azyan',
      body: 'hello welcome to sallon azyan',
      image: 'assets/1.jpg'),
  onbordModel(
      title: 'Azyan',
      body: 'hello welcome to sallon azyan',
      image: 'assets/2.jpg'),
  onbordModel(
      title: 'Azyan',
      body: 'hello welcome to sallon azyan',
      image: 'assets/3.jpg'),
];

class OnBording_Screen extends StatefulWidget {
  @override
  State<OnBording_Screen> createState() => _OnBording_ScreenState();
}

class _OnBording_ScreenState extends State<OnBording_Screen> {
  var Pagecontrolar = PageController();

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                cachHelper.Savedataa(key: 'ShowOnBoard', value: false)
                    .then((value) {
                  if (value) {
                    print(value);
                     NavegatandFinish(context, LoginScreen());
                  }
                });
              },
              child: const Text(
                'SKIP',
                style: TextStyle(
                  color: Colors.deepOrange,
                ),
              )),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                if (index == screens.length - 1) {
                  setState(() {
                    islast = true;
                  });
                } else {
                  setState(() {
                    islast = false;
                  });
                }
              },
              physics: const BouncingScrollPhysics(),
              controller: Pagecontrolar,
              itemBuilder: (context, index) =>
                  buildonbordingScreen(screens[index]),
              itemCount: screens.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: Pagecontrolar,
                  count: screens.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.deepOrange,
                    spacing: 5.0,
                    expansionFactor: 4,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      cachHelper.Savedataa(key: 'ShowOnBoard', value: false)
                          .then((value) {
                        if (value) {
                          print(value);
                           NavegatandFinish(context, SalonOrServicesOrUser());
                        }
                      });
                      print('last');
                    } else {
                      Pagecontrolar.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  backgroundColor: Colors.deepOrange,
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}

Widget buildonbordingScreen(onbordModel model) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(
              model.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Text(
            model.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
        ),
        //separator(0, 10),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model.body,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );

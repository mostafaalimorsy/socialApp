import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/constant.dart';
import 'package:social_test/controller/service/icon_broken.dart';

Widget BuildSideBar(BuildContext context) {

  GlobalKey<ScaffoldState> _key = GlobalKey();
  return BlocConsumer<SocialAppCubit, SocialAppStates>(
    listener: (BuildContext context, state) {  },
    builder: (BuildContext context, SocialAppStates state) {
      SocialAppCubit getData = SocialAppCubit.get(context);
      var userModer = getData.model;
      return  Drawer(

        backgroundColor: getData.isDarkModeEnabled ? Colors.black : Colors.white,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        height: 120,
                        width: double.infinity,
                        child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4.0),
                                        topLeft: Radius.circular(4.0),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            '${userModer!.cover}',
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                  NetworkImage('${userModer.image}'),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),

              ),

            ),
            SizedBox(height: 10,),
            ListTile(
              title: Row(
                children: [
                  IconButton(onPressed: (){
                    getData.changeAppMode();
                  },
                      icon: const Icon(Icons.brightness_4_outlined,
                        size: 35,
                        color: defaultColor,)),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Dark mode is ' +
                      (getData.isDarkModeEnabled ? 'enabled' : 'disabled') +
                      '.'),
                ],
              ),
              onTap: () {
                getData.changeAppMode();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Logout,
                      size: 35,
                      color: defaultColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Sign-out")
                  ],
                ),
              ),
              onTap: () {
                getData.signOut(context);
              },
            ),
          ],
        ),
      );
    },

  );
}

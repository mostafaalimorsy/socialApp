import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/componans.dart';
import 'package:social_test/controller/service/constant.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/view/screen/new_post/new_post.dart';
import 'package:social_test/view/widget/private_setting_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {
        if (state is SocialNewsPostState) navigatTo(context, NewPost());
      },
      builder: (BuildContext context, SocialAppStates state) {
        SocialAppCubit getData = SocialAppCubit.get(context);
        var userModer = getData.model;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              getData.titles[getData.currentIndex],
            ),
          ),
          drawer: BuildSideBar(context),
          body: getData.bottomScreen[getData.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: getData.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: "Post"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: "Setting"),
            ],
            onTap: (index) {
              getData.changBottom(index);
            },
          ),
        );
      },
    );
  }
}

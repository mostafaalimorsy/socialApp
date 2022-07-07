import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/componans.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, SocialAppStates state) {
        SocialAppCubit getData = SocialAppCubit.get(context);
        var model = getData.model;
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) {
               return buildChatItem(model);
            }, separatorBuilder: (context,index) {
              return MyDivider();
        }, itemCount: 10);
      },
    );
  }

  Widget buildChatItem(model) {
    return InkWell(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top:2 ),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${model!.image}',
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  "${model.name}",
                  style: TextStyle(height: 1.4),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

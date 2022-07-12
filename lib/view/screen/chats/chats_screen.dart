import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/componans.dart';
import 'package:social_test/model/social_user_model.dart';
import 'package:social_test/view/screen/chats/chat_deatils_screen.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, SocialAppStates state) {
        SocialAppCubit getData = SocialAppCubit.get(context);

        return ConditionalBuilder(
          condition: getData.users.isNotEmpty,
          builder: (BuildContext context) {
            return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index) {
                  return buildChatItem(getData.users[index],context);
                }, separatorBuilder: (context,index) {
              return MyDivider();
            }, itemCount: getData.users.length
            );
          },
          fallback: (BuildContext context) {
            return Center(child: CircularProgressIndicator(),);
          },

        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model,context) {
    return InkWell(
      onTap: (){
        navigatTo(context, ChatDetailsScreen(model: model,));

      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top:2 ),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  "${model.name}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

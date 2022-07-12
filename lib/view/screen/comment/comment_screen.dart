import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/model/comment_model.dart';

class CommentScreen extends StatelessWidget {
  var _textCommentController = TextEditingController();
   String uIdIndex;


  CommentScreen(this.uIdIndex);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = SocialAppCubit.get(context);

        return Scaffold(
            appBar: AppBar(
            ),
            body: Text("njljn"));
      },
    );
  }

  Widget commentItem(context, CommentModel model,index) {
    return Column(
      children: [
        if (model.postId == uIdIndex)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage:   NetworkImage(
                  "${model.image}"               ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18.0,
                            color: Colors.black,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Text(
                        '${model.textComment}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            height: 1.6, fontSize: 15, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
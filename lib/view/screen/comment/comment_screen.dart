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
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => commentItem(
                                context,
                               SocialAppCubit.get(context).commentsModel[index],index),
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 8.0,
                            ),
                            itemCount: cubit.commentsModel.length,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _textCommentController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: 'Write a Comment',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: InkWell(
                          child: const Icon(Icons.camera_alt),
                          onTap: () {
                            cubit.getCommentImage();
                          },
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (cubit.commentImage == null) {
                              cubit.createComment(
                                textComment: _textCommentController.text,
                                postId: uIdIndex,
                                uidComment: uIdIndex,
                              );
                            } else {
                              cubit.uploadCommentImage(
                                textComment: _textCommentController.text,
                                uidComment: uIdIndex,
                                postId: uIdIndex,
                              );
                            }
                            _textCommentController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black, height: 1),
                    ),
                  ],
                )));
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/social_app/cubit.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/componans.dart';
import 'package:social_test/controller/service/constant.dart';
import 'package:social_test/controller/service/icon_broken.dart';
import 'package:social_test/view/screen/main_screen.dart';

class NewPost extends StatelessWidget {
   NewPost({Key? key}) : super(key: key);

  var textController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit , SocialAppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, SocialAppStates state) {
        SocialAppCubit getData = SocialAppCubit.get(context);
        var model= getData.model;
        var postModel=getData.post_model;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: Icon(IconBroken.Arrow___Left_2) ,),
            title: Text("Create Post"),
            actions: [
              TextButton(onPressed: (){
                var now= DateTime.now();
                if(getData.postImage == null)
                  {
                    getData.createPost(dateTime: now.toString(), text: textController.text);
                    Navigator.pop(context);
                  }else{
                    getData.uploadPostImage(dateTime: now.toString(), text: textController.text);
                    Navigator.pop(context);
                }

              }, child: Text("Post"))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingStates) LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingStates) SizedBox(height: 10,),
                Row(
                  children: [
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
                        '${model.name}',
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "what is on your minde",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if( getData.postImage !=null) SizedBox(height: 10,),
                if( getData.postImage !=null)
                Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image:  FileImage(getData.postImageFile!),
                          fit: BoxFit.cover,
                        ),
                  ),

                ),
                        IconButton(
                          color: defaultColor,
                          onPressed: (){
                          getData.removePostImage();
                        }, icon: Icon(Icons.close),),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        getData.getPostImage();
                      }, child: Row(
                        children: [
                          Icon(IconBroken.Image),
                          SizedBox(width: 5,),
                          Text("Add photo")
                        ],
                      )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){}, child: Text("# Tags")),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

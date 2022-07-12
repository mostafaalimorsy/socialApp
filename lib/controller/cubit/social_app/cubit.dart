import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_test/controller/cubit/social_app/states.dart';
import 'package:social_test/controller/service/cash_helper.dart';
import 'package:social_test/controller/service/componans.dart';
import 'package:social_test/controller/service/constant.dart';
import 'package:social_test/model/comment_model.dart';
import 'package:social_test/model/msg_model.dart';
import 'package:social_test/model/post_mode.dart';
import 'package:social_test/model/social_user_model.dart';
import 'package:social_test/view/screen/Auth/login/login_screen.dart';
import 'package:social_test/view/screen/chats/chats_screen.dart';
import 'package:social_test/view/screen/new_post/new_post.dart';
import 'package:social_test/view/screen/news_feed/NewsFeedScreen.dart';
import 'package:social_test/view/screen/settings/settings_screen.dart';
import 'package:social_test/view/screen/users/users_screen.dart';

class SocialAppCubit extends Cubit<SocialAppStates>{
  SocialAppCubit() : super(IntialSocialAppStates ());

  static SocialAppCubit get(context) => BlocProvider.of(context);

  bool isDarkModeEnabled=false;
  int currentIndex = 0 ;
  List <Widget> bottomScreen = [
    FeedScreen(),
    ChatScreen(),
    NewPost(),
    UsersScreen(),
    SettingScreen(),
  ];

  List <String> titles = [
   " News Feed",
    " Chat",
    "New Post",
    " Users",
    " Setting",
  ];
  void changBottom (int index)
  {

    if(index == 1) getAllUsers();
    if( index == 2)
      {
        emit(SocialNewsPostState());
      }else{
      currentIndex=index;
      emit(SocialBottomNavigationBarstate());
    }

  }


  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode ({bool? fromShared})
  {

    fromShared !=null ? isDarkModeEnabled =fromShared :
    isDarkModeEnabled = !isDarkModeEnabled;
    CachHelper.saveData(key: 'isDark', value: isDarkModeEnabled).then((value) => emit(ChangeModeSocialAppStates()));

  }
  void onStateChanged(bool isDarkModeEnabled) {

      isDarkModeEnabled = isDarkModeEnabled;

  }
  SocialUserModel? model;
  void getUserData(){
    emit(SocialAppLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model= SocialUserModel.fromJson(value.data() as Map<String,dynamic>);
      print(value.data());
      emit(SocialAppScuccessStates());
    });
  }

  final ImagePicker picker = ImagePicker();
  XFile? coverImage;
  File? coverImageFile;
  Future<void> getCoverImage() async {
    coverImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (coverImage != null) {
      coverImageFile = File(coverImage!.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialCoverImagePickedErorrState());
    }
  }

  XFile? profileImage;
  File? profileImageFile;
  Future<void> getProfileImage() async {
    profileImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (profileImage != null) {
      profileImageFile = File(profileImage!.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialProfileImagePickedErorrState());
    }
  }

  String profileImageUrl = "";
  void uploadProfileImage({
     String? name,
     String? phone,
     String? bio,
     String? email,
  }) async {
    emit(SocialUserImagesUpdateloadingStates());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImageFile!) //image waslet el storage
        .then((value) {
      value.ref.getDownloadURL().then(
            (value) {
              print(value);
          profileImageUrl = value;
          updateUser(
            email: email,
            name: name,
            phone: phone,
            bio: bio,
            image: value,

          );
          emit(SocialUploadImageProfileSuccessStates());
        },
      ).catchError(
            (error) {
          emit(SocialUploadImageProfileErorrStates());
        },
      );
    }).catchError(
          (error) {
        print(error.toString());
        emit(SocialUploadImageProfileErorrStates());
      },
    );
  }

  String coverImageUrl = "";
  void uplodCoverImage({
     String? name,
     String? phone,
     String? bio,
     String? email,
  }) async {
    emit(SocialUserImagesUpdateloadingStates());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImageFile!) //image waslet el storage
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        updateUser(
          email: email,
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        emit(SocialUploadImageCoverSuccessStates());
      }).catchError((erorr) {
        print(erorr);
        emit(SocialUploadImageCoverErorrStates());
      });
    }).catchError((erorr) {
      print(erorr);
      emit(SocialUploadImageCoverErorrStates());
    });
  }

  void updateUser({
    required String? name,
    required String? phone,
    required String? bio,
    required String? email,
    String? cover,
    String? image,

  }) {
    emit(SocialUpdateUserloadingStates());
    SocialUserModel socialUserModel = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: uId,
      email: email,
      isEmailVerified: true,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(socialUserModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((erorr) {
      print(erorr);
      emit(SocialUserUpdateErorrStates());
    });
  }
  //
  XFile? postImage;
  File? postImageFile;
  Future<void> getPostImage() async {
    postImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (postImage != null) {
      postImageFile = File(postImage!.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialPostImagePickedErorrState());
    }
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(SocialCreatePostLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        //emit(SocialUploadPostImageSuccessStates());
      }).catchError((erorr) {
        emit(SocialUploadPostImageErorrStates());
      });
    }).catchError((erorr) {
      emit(SocialUploadPostImageErorrStates());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingStates());
    PostModel postModel = PostModel(
      image: model!.image,
      name: model!.name,
      uId: model!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessStates());
    }).catchError((erorr) {
      emit(SocialCreatePostErorrStates());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageStates());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  PostModel? post_model;
  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);


          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSucsessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErorrState(error.toString()));
    });
  }

  List<int> userPosts = [];
  var postLength;
  var PostUId;
  void getUserPotstsLength() {
    emit(SocialGetMessageLoginState());
    userPosts = [];
    var userPostsCount = FirebaseFirestore.instance.collection('posts');
    userPostsCount.where('uId', isEqualTo: uId).get().then((value) {
      value.docs.forEach((element) {
        // postLength = element;
        userPosts.add(element.data().length);
      });
      postLength = userPosts.length;

      emit(SocialGetUserPostsLengthSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialGetUserPostsLengthErorrState());
    });
  }
  //
  // List<dynamic> follrwersLength = [];
  // var follrwersCount;
  //
  // void getUserFolloewrsLength() {
  //   emit(SocialGetUserFollowersLengthLoadingState());
  //   follrwersLength = [];
  //   var userFollowersCount = FirebaseFirestore.instance.collection('users');
  //   userFollowersCount.doc(uId).collection("chats").get().then((value) {
  //     follrwersCount = value.docs.length;
  //     //follrwersCount = follrwersLength;
  //     print(follrwersCount);
  //
  //     emit(SocialGetUserFollowersLengthSuccessState());
  //   }).catchError((erorr) {
  //     print(erorr.toString());
  //     emit(SocialGetUserFollowersLengthErorrState());
  //   });
  // }
  //
  void addToFavorites(  {
    String? name,
    String? uId,
    String? image,
    String? dateTime,
    String? text,
    String? postImage,
    String? postsId,

  }) {
    emit(SocialAddToFavoritesLoadingState());
    PostModel postModel = PostModel(
        dateTime: dateTime,
        uId: uId,
        image: image,
        name: name,
        postImage: postImage ?? '',
        text: text ?? '');
    FirebaseFirestore.instance
        .collection("users")
        .doc(model!.uId)
        .collection("favoritesList")
        .add(postModel.toMap())
        .then((value) {
      emit(SocialAddToFavoritesSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialAddToFavoritesErorrState());
    });
  }

  List<PostModel> favoritesList = [];
  void getFavoritesList() {
    favoritesList = [];
    emit(SocialGetFavoritesLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(model!.uId)
        .collection("favoritesList")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        favoritesList.add(PostModel.fromJson(element.data()));
      });
      print(favoritesList.length);
      emit(SocialGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetFavoritesErorrState());
    });
  }

  void removeFromFavorites(postid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(model!.uId)
        .collection("favoritesList")
        .doc(postid)
        .delete()
        .then((value) {
      emit(SocialRemoveFromFavoritesSuccessState());
    }).catchError((erorr) {
      emit(SocialRemoveFromFavoritesErorrState());

      print(erorr);
    });
  }
  //
  // void addToWatchLater({
  //   String? name,
  //   String? uId,
  //   String? image,
  //   String? dateTime,
  //   String? text,
  //   String? postImage,
  //   String? postsId,
  // }) {
  //   emit(SocialAddToWatchLaterLoadingState());
  //   PostModel postModel = PostModel(
  //       dateTime: dateTime,
  //       uId: uId,
  //       image: image,
  //       name: name,
  //       postImage: postImage ?? '',
  //       text: text ?? '');
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userModel!.uId)
  //       .collection("watchlaterList")
  //       .add(postModel.toMap())
  //       .then((value) {
  //     emit(SocialAddToWatchLaterSuccessState());
  //   }).catchError((erorr) {
  //     print(erorr.toString());
  //     emit(SocialAddToWatchLaterErorrState());
  //   });
  // }
  //
  // List<PostModel> watchLaterList = [];
  // void getWatchLaterList() {
  //   watchLaterList = [];
  //   emit(SocialGetWatchLaterLoadingState());
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(userModel!.uId)
  //       .collection("watchlaterList")
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       watchLaterList.add(PostModel.fromJson(element.data()));
  //     });
  //     print(favoritesList.length);
  //     emit(SocialGetWatchLaterSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialGetWatchLaterErorrState());
  //   });
  // }
  //
  void likePost(String postId) {
    emit(SocialPostLikesLoadingState());
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(model!.uId)
        .set({
      'likes': true,
    }).then((value) {
      emit(SocialPostLikesSucsessState());
    }).catchError((erorr) {
      emit(SocialPostLikesErorrState(erorr));
    });
  }

  XFile? commentImage;
  File? commentImageFile;
  Future<void> getCommentImage() async {
    commentImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (commentImage != null) {
      commentImageFile = File(commentImage!.path);
      emit(SocialCommentImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialCommentImagePickedErorrState());
    }
  }

  void uploadCommentImage({
    required String uidComment,
    required String textComment,
    String? postId,
  }) {
    emit(SocialCreatePostLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("comments/${Uri.file(commentImage!.path).pathSegments.last}")
        .putFile(commentImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createComment(
          uidComment: uidComment,
          textComment: textComment,
          imageComment: value,
          postId: postId!,
        );
      }).catchError((erorr) {
        emit(SocialUploadCommentImageErorrStates());
      });
    }).catchError((erorr) {
      emit(SocialUploadCommentImageErorrStates());
    });
  }

  void createComment({
    required String uidComment,
    required String textComment,
    String? imageComment,
    String? postId,
  }) {
    emit(SocialCreateCommentLoadingStates());
    CommentModel commentModel = CommentModel(
      name: model!.name,
      textComment: textComment,
      image: model!.image,
      uId: model!.uId,
      imageComment: imageComment,
      postId: postId,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .doc(uidComment)
        .collection("comments")
        .doc(model!.uId)
        .set(commentModel.toMap())
        .then((value) {
      emit(SocialCreateCommentSuccessStates());
    }).catchError((erorr) {
      emit(SocialCreateCommentErorrStates());
    });
  }

  List<CommentModel> commentsModel = [];
  List<String> postsIdComment = [];

  List<int> comments = [];

  void getComments() {
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          postsIdComment.add(element.id);
          commentsModel.add(CommentModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetCommentsSuccsessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetCommentsErorrState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];
  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    if (users.isEmpty) //3lshan msh kol mra yro7 ygep elUsers keda ygep elUsers
      //lma tkon el lest fadya bs ya3ny awel m aft7 el chats bs ygep kol elUser
      //f lma adeef 7ad gded hegepo brdo 3lshan begep lma bfta7 elChat
        {
      FirebaseFirestore.instance.collection("users").get().then((value) {
        value.docs.forEach((element) {
          if (element['uId'] != model!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
          emit(SocialGetAllUsersSuccessState());
        });
      }).catchError((erorr) {
        print(erorr.toString());
        emit(SocialGetAllUsersErorrState(erorr.toString()));
      });
    }
  }

  void sendMessage({
    required String reciverId,
    required String text,
    required String dateTime,
  }) {
    emit(SocialSendMessageLoadingState());
    MessagerModel messagerModel = MessagerModel(
      senderId: model!.uId,
      reciverId: reciverId,
      text: text,
      dateTime: dateTime,
    );
    // my message
    FirebaseFirestore.instance
        .collection("users")
        .doc(model!.uId)
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .add(messagerModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((erorr) {
      emit(SocialSendMessageErorrState(erorr));
    });
    // reciver message
    FirebaseFirestore.instance
        .collection("users")
        .doc(reciverId)
        .collection("chats")
        .doc(model!.uId)
        .collection("messages")
        .add(messagerModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((erorr) {
      emit(SocialSendMessageErorrState(erorr));
    });
  }

  List<MessagerModel> message = [];
  void getMessages({
    required String reciverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(model!.uId)
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(
          MessagerModel.fromJson(element.data()),
        );
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      CachHelper.clearData(key: 'uId').then((value) => navigatTo(context, LoginScreen()));
      emit(SocialUserSignOutSuccessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(SocialUserSignOutErorrState());
    });
  }











}
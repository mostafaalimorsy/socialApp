import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/auth/rigester/states.dart';
import 'package:social_test/model/social_user_model.dart';

class SocialRigesterCubit extends Cubit<SocialAppRigesterStates> {
  SocialRigesterCubit() : super(IntialSocialAppRigesterStates());

  static SocialRigesterCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility_outlined;

  bool password = true;



  void CreatUser(
      {required String email,
        required String name,
        required String uId,
        required String phone}) async {
    emit(SocialAppLoadingCreateUsersStates());
    SocialUserModel  model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      cover: 'https://img.freepik.com/free-vector/group-man_1284-12615.jpg?w=900&t=st=1656891997~exp=1656892597~hmac=d846874cb55fdffb71a69b9f98b13c9cc7f46debb54f708af1c14680d0c1af2b',
      bio: 'write your bio',
      image: 'https://img.freepik.com/free-photo/man-with-laptop-thinking_1368-5024.jpg?t=st=1656880893~exp=1656881493~hmac=66292ed372d99d122326d94ce038797e363ff2a59820ce39e175058dafa396f7&w=740',
      isEmailVerified: FirebaseAuth.instance.currentUser!.emailVerified
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)
    {
      emit(SocialAppSucessCreateUsersStates());
    });


  }

  // Auth data TO API
  void PostLogin(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    emit(SocialAppLoadingRigesterStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          CreatUser(email: email, name: name, phone: phone, uId: value.user!.uid);
    });
  }




  // To change Password Visiability
  void changPasswordVisiability() {
    password = !password;
    suffix =
        password ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangPasswordVisabilityRigesterStates());
  }
}

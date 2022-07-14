import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_test/controller/cubit/auth/login/cubit/states.dart';
import 'package:social_test/controller/service/cash_helper.dart';


class SocialLoginCubit extends Cubit<SocialAppLoginStates> {
  SocialLoginCubit() : super(IntialShopAppLoginStates ());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // ShopLoginModel? PostLogin ;
  // ShopLoginModel? GetLogin ;
  IconData suffix = Icons.visibility_outlined ;
  bool password = true;



  void GetLogin({required String email , required String password })  {
    emit(SocialAppLoadingStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      var id= value.user!.uid;
      print(value.user!.uid);
      CashHelper.saveData(key: 'uId', value: value.user!.uid).then((value) => emit(SocialAppScuccessStates(id)));
    });


  }

  //To change Password Visiability
  void changPasswordVisiability( ){
    password = !password;
    suffix = password ?  Icons.visibility_outlined : Icons.visibility_off_outlined   ;
    emit(SocialChangPasswordVisabilityStates());


  }



}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_test/controller/service/componans.dart';


Widget CustomTextButton ({context, route, text}) => TextButton(

  onPressed: () {
    navigatTo(context, route);
  },
  child: Text("${text}"),
);
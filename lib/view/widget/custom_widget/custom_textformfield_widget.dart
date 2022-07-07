import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultTextForm({
  controller,
  labelText,
  dynamic icon,
  hintText,
  dynamic type,
  msg,
  dynamic visableIcon,
  bool passwd = false,
  ValueChanged<String>? onSubmitted,
  GestureTapCallback? onTap
}) =>
    TextFormField(
      obscureText: passwd == false ? false : true,
      onFieldSubmitted: onSubmitted,
      controller: controller,
      keyboardType: type,
      validator: (String? value) {
        if (value!.isEmpty) {
          return '${msg}';
        }
      },
      decoration: InputDecoration(
        suffixIcon: InkWell(
          child: Icon(visableIcon),
          onTap: onTap,
        ),
        contentPadding: EdgeInsets.all(24),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        label: Text("${labelText}"),
        prefix: Icon(icon),
        hintText: "${hintText}",
      ),
    );

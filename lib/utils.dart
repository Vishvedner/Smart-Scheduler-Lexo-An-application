import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) =>
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          elevation: 6.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            duration: new Duration(milliseconds: 500),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 45.0, left: 10, right: 50,),
            content: Text(text,style: TextStyle(color: Colors.white),),
        ));

  static DateTime toDateTime(Timestamp value) {
    if (value == null);

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>> transformer<T>(
      T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps.map((json) => fromJson(json)).toList();

          sink.add(users);
        },
      );
}
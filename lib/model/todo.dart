import 'package:flutter/material.dart';
import 'package:smart_scheduler_marked/utils.dart';

class TodoField{
  static const createdTime = 'createdTime';
}

class Todo{
  late DateTime createdTime;
  late String title;
  late String id;
  late String description;
  late String notifier;
  late String time;
  late bool isDone;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.notifier ='',
    this.time = '',
    this.id = '',
    this.isDone = false,
});

  static Todo fromJson(Map<String , dynamic> json) => Todo(
    createdTime: Utils.toDateTime(json['createdTime']),
    title: json['title'],
    description: json['description'],
    notifier: json['notifier'],
    time: json['time'],
    id: json['id'],
    isDone: json['isDone'],
  );

  Map<String, dynamic> toJson() => {
    'createdTime': Utils.fromDateTimeToJson(createdTime),
    'title': title,
    'description': description,
    'notifier': notifier,
    'time': time,
    'id': id,
    'isDone': isDone,
  };

}
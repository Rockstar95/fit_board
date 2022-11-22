import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../utils/parsing_helper.dart';

@immutable
class BoardModel extends Equatable {
  final String id, displayName, data;
  final int priority;
  final TextEditingController textEditingController;

  const BoardModel({
    required this.id,
    required this.displayName,
    required this.data,
    required this.priority,
    required this.textEditingController,
  });

  BoardModel updateUserData({String? id, String? displayName, String? data, int? priority, TextEditingController? textEditingController}) {
    return BoardModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      data: data ?? this.data,
      priority: priority ?? this.priority,
      textEditingController: textEditingController ?? this.textEditingController,
    );
  }

  static BoardModel fromMap(Map<String, dynamic> map) {
    return BoardModel(
      id: ParsingHelper.parseStringMethod(map['id']),
      displayName: ParsingHelper.parseStringMethod(map['displayName']),
      data: ParsingHelper.parseStringMethod(map['data']),
      priority: ParsingHelper.parseIntMethod(map['priority']),
      textEditingController: TextEditingController(),
    );
  }

  Map<String, dynamic> toMap({bool toJson = false}) {
    return {
      "id" : id,
      "displayName" : displayName,
      "data" : data,
      "priority" : priority,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap(toJson: true));
  }

  @override
  List<Object?> get props => [id, displayName, data, priority];
}
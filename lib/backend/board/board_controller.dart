import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_board/configs/constants.dart';
import 'package:fit_board/configs/typedefs.dart';
import 'package:fit_board/model/board_model.dart';
import 'package:fit_board/utils/my_print.dart';
import 'package:fit_board/utils/parsing_helper.dart';
import 'package:flutter/material.dart';

import 'board_provider.dart';

class BoardController {
  final BoardProvider boardProvider;

  const BoardController({required this.boardProvider});

  Future<void> startBoardsListening() async {
    if(boardProvider.getBoardsDataStreamSubscription != null) {
      boardProvider.stopBoardsDataStreamSubscription(isNotify: false);
    }

    boardProvider.setBoardsDataStreamSubscription(subscription: FirebaseNodes.boardDataDocumentReference.snapshots().listen((MyFirestoreDocumentSnapshot snapshot) {
      MyPrint.printOnConsole("Data in BoardSubscription:${snapshot.data()}");

      Map<String, BoardModel> map = <String, BoardModel>{};

      snapshot.data()?.forEach((String key, dynamic value) {
        Map<String, dynamic> valueMap = ParsingHelper.parseMapMethod<dynamic, dynamic, String, dynamic>(value);
        if(valueMap.isNotEmpty) {
          BoardModel boardModel = BoardModel.fromMap(valueMap);
          map[boardModel.id] = boardModel;
        }
      });

      List<String> boardsIds = (map.values.toList()..sort((a, b) => a.priority.compareTo(b.priority))).map((e) => e.id).toList();

      boardProvider.setBoardsIdsList(data: boardsIds, isNotify: false);

      String selectedBoard = boardProvider.selectedBoard;
      if(selectedBoard.isNotEmpty && !boardsIds.contains(selectedBoard)) {
        boardProvider.setSelectedBoard(selectedBoard: boardsIds.first, isNotify: false);
      }

      boardProvider.setBoardsMap(data: map, isNotify: true);
    }), isNotify: false);
  }

  void stopBoardsDataStreamSubscription() {
    boardProvider.stopBoardsDataStreamSubscription(isNotify: false);
    boardProvider.setBoardsMap(data: {});
  }

  Future<void> updateBoardData(Map<String, BoardModel> data) async {
    MyPrint.printOnConsole("updateBoardData called with data:$data");

    if(data.isEmpty) return;

    await FirebaseNodes.boardDataDocumentReference.set(data.map((key, value) => MapEntry(key, value.toMap())), SetOptions(merge: true));
  }


  Future<void> resetBoardsData() async {
    Map<String, BoardModel> data = boardProvider.boardsMap.map((key, value) => MapEntry(key, value.updateUserData(data: '')));

    await updateBoardData(data);
  }

  Future<void> resetBoards() async {
    Map<String, BoardModel> data = <String, BoardModel>{};

    for (int i = 1; i <= 10; i++) {
      BoardModel boardModel = BoardModel(
        id: "Tab$i",
        displayName: "Board$i",
        data: "",
        priority: i,
        textEditingController: TextEditingController(),
      );
      data[boardModel.id] = boardModel;
    }

    await updateBoardData(data);
  }
}
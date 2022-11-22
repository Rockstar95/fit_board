import 'dart:async';

import 'package:fit_board/configs/typedefs.dart';
import 'package:fit_board/model/board_model.dart';
import 'package:flutter/foundation.dart';

class BoardProvider extends ChangeNotifier {
  //region Selected Board Data
  String _selectedBoard = "";

  String get selectedBoard => _selectedBoard;

  void setSelectedBoard({required String selectedBoard, bool isNotify = true}) {
    _selectedBoard = selectedBoard;
    if(isNotify) notifyListeners();
  }
  //endregion

  //region Boards Ids List Data
  final List<String> _boardsIdsList = <String>[];

  List<String> get boardsIdsList => _boardsIdsList;

  void setBoardsIdsList({required List<String> data, bool isClear = true, bool isNotify = true}) {
    List<String> boardData = boardsIdsList;

    if(isClear) boardData.clear();

    boardData.addAll(data);

    if(isNotify) notifyListeners();
  }
  //endregion

  //region Boards Map Data
  final Map<String, BoardModel> _boardsMap = <String, BoardModel>{};

  Map<String, BoardModel> get boardsMap => _boardsMap;

  void setBoardsMap({required Map<String, BoardModel> data, bool isClear = true, bool isNotify = true}) {
    Map<String, BoardModel> boardData = boardsMap;

    if(isClear) boardData.clear();

    boardData.addAll(data);

    if(isNotify) notifyListeners();
  }
  //endregion

  //region Boards Data StreamSubscription
  StreamSubscription<MyFirestoreDocumentSnapshot>? _boardsDataStreamSubscription;

  StreamSubscription<MyFirestoreDocumentSnapshot>? get getBoardsDataStreamSubscription => _boardsDataStreamSubscription;

  void setBoardsDataStreamSubscription({required StreamSubscription<MyFirestoreDocumentSnapshot> subscription, bool isNotify = true}) {
    stopBoardsDataStreamSubscription(isNotify: false);
    _boardsDataStreamSubscription= subscription;
    if(isNotify) notifyListeners();
  }

  void stopBoardsDataStreamSubscription({bool isNotify = true}) {
    _boardsDataStreamSubscription?.cancel();
    _boardsDataStreamSubscription = null;
    if(isNotify) notifyListeners();
  }
  //endregion
}
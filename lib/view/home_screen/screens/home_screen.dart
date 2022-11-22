import 'package:fit_board/backend/app/app_controller.dart';
import 'package:fit_board/backend/board/board_controller.dart';
import 'package:fit_board/backend/board/board_provider.dart';
import 'package:fit_board/backend/navigation/navigation_controller.dart';
import 'package:fit_board/model/board_model.dart';
import 'package:fit_board/utils/extensions.dart';
import 'package:fit_board/utils/my_print.dart';
import 'package:fit_board/utils/my_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../../common/components/bordered_button.dart';
import '../../common/components/common_rich_text_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BoardController boardController;
  late BoardProvider boardProvider;

  late ThemeData themeData;

  void onBoardCardTap({required BoardModel boardModel}) {
    MyPrint.printOnConsole("onBoardCardTap called for Board Id:${boardModel.id}");
    
    if(boardProvider.selectedBoard != boardModel.id) {
      boardProvider.setSelectedBoard(selectedBoard: boardModel.id);
    }
  }

  void onBoardCopyTap({required BoardModel boardModel}) {
    MyPrint.printOnConsole("onBoardCopyTap called for Board Id:${boardModel.id}");

    MyUtils.copyToClipboard(context, boardModel.data);
  }

  void onUpdateBoardTap({required BoardModel boardModel, required String newText}) {
    MyPrint.printOnConsole("onBoardCopyTap called for Board Id:${boardModel.id}");

    if(boardModel.data == newText) return;

    BoardModel newBoardModel = boardModel.updateUserData(data: newText);

    boardController.updateBoardData({newBoardModel.id : newBoardModel});
    newBoardModel.textEditingController.clear();
  }

  @override
  void initState() {
    super.initState();
    boardProvider = Provider.of<BoardProvider>(NavigationController.mainScreenNavigator.currentContext!, listen: false);
    boardController = BoardController(boardProvider: boardProvider);

    boardProvider.setSelectedBoard(selectedBoard: boardProvider.boardsIdsList.firstElement ?? "", isNotify: false);
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    MyPrint.printOnConsole("HomeScreen Build Called");

    return Scaffold(
      appBar: getAppBar(),
      body: Consumer<BoardProvider>(
        builder: (BuildContext context, BoardProvider boardProvider, Widget? child) {
          String selectedBoardId = boardProvider.selectedBoard;

          return Row(
            children: [
              getBoardSelectionSidebar(provider: boardProvider),
              Expanded(
                child: getSelectedBoardWidget(boardModel: selectedBoardId.isNotEmpty ? boardProvider.boardsMap[selectedBoardId] : null),
              ),
            ],
          );
        },
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: const Text("Boards"),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset(
          "assets/images/logo.png",
          width: 500,
          height: 300,
        ),
      ),
      leadingWidth: 200,
    );
  }

  Widget getBoardSelectionSidebar({required BoardProvider provider}) {
    List<String> boardIds = provider.boardsIdsList;
    Map<String, BoardModel> boardMap = provider.boardsMap;
    if(boardIds.isEmpty) return const Center(child: Text("No Boards Available"),);

    return SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: boardIds.map((String boardId) {
            BoardModel? boardModel = boardMap[boardId];

            if(boardModel != null) {
              return getBoardNameCard(boardModel: boardModel, isSelected: provider.selectedBoard == boardId);
            }
            else {
              return const SizedBox();
            }
          }).toList(),
        ),
      );
  }

  Widget getBoardNameCard({required BoardModel boardModel, bool isSelected = false}) {
    return BoardCardWidget(
      boardModel: boardModel,
      onBoardCardTap: onBoardCardTap,
      isSelected: isSelected,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: GestureDetector(
        onTap: () {
          onBoardCardTap(boardModel: boardModel);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.blue : themeData.backgroundColor,
            ),
            borderRadius: BorderRadius.circular(AppUIConfiguration.borderRadius),
          ),
          child: Text(
            boardModel.displayName,
            style: TextStyle(
              fontSize: isSelected ? 16 : 14,
              color: isSelected ? Colors.blue : null,
              fontWeight: isSelected ? FontWeight.w700 : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget getSelectedBoardWidget({BoardModel? boardModel}) {
    if(boardModel == null) return const SizedBox();

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: themeData.backgroundColor),
        borderRadius: BorderRadius.circular(AppUIConfiguration.borderRadius),
      ),
      child: Column(
        children: [
          Expanded(
            child: boardModel.data.isNotEmpty ? Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Expanded(child: SelectableText(boardModel.data)),
                    Expanded(
                      child: CommonRichTextView(
                        url: boardModel.data,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: BorderedButton(
                    onTap: () {
                      onBoardCopyTap(boardModel: boardModel);
                    },
                    child: const Text("Copy"),
                  ),
                ),
              ],
            ) : const Center(child: Text("Nothing on the board"),),
          ),
          if(AppController().isAdminApp) TextField(
            controller: boardModel.textEditingController,
            onSubmitted: (String text) {
              MyPrint.printOnConsole("onSubmitted called with text:'$text'");
            },
            minLines: 5,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: "Enter Code",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: themeData.backgroundColor),
              ),
              suffixIcon: Container(
                margin: EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {
                    onUpdateBoardTap(boardModel: boardModel, newText: boardModel.textEditingController.text);
                  },
                  icon: const Icon(Icons.send),
                  splashRadius: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoardCardWidget extends StatefulWidget {
  final BoardModel boardModel;
  final bool isSelected;
  final void Function({required BoardModel boardModel}) onBoardCardTap;

  const BoardCardWidget({
    Key? key,
    required this.boardModel,
    required this.onBoardCardTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<BoardCardWidget> createState() => _BoardCardWidgetState();
}

class _BoardCardWidgetState extends State<BoardCardWidget> {
  late ThemeData themeData;

  late BoardModel boardModel;
  bool isSelected = false;
  late void Function({required BoardModel boardModel}) onBoardCardTap;

  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    boardModel = widget.boardModel;
    isSelected = widget.isSelected;
    onBoardCardTap = widget.onBoardCardTap;
  }

  @override
  void didUpdateWidget(covariant BoardCardWidget oldWidget) {
    if(boardModel != widget.boardModel || isSelected != widget.isSelected) {
      boardModel = widget.boardModel;
      isSelected = widget.isSelected;
      onBoardCardTap = widget.onBoardCardTap;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        onTap: () {
          onBoardCardTap(boardModel: widget.boardModel);
        },
        borderRadius: BorderRadius.circular(AppUIConfiguration.borderRadius),
        onHover: (bool isHovered) {
          // MyPrint.printOnConsole("onHover called for Board Id:${boardModel.id}, with isHovered:$isHovered");
          this.isHovered = isHovered;
          setState(() {});
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.blue : themeData.backgroundColor,
            ),
            borderRadius: BorderRadius.circular(AppUIConfiguration.borderRadius),
          ),
          child: Text(
            boardModel.displayName,
            style: TextStyle(
              fontSize: isSelected ? 15 : 14,
              color: isSelected || isHovered ? Colors.blue : null,
              fontWeight: isSelected || isHovered ? FontWeight.w600 : null,
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter_connect_four_youtube/screens/game_screen/widgets/cell.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  RxList<List<int>> _board = RxList<List<int>>();
  List<List<int>> get board => _board.value;
  set board(List<List<int>> value) => _board.value = value;

  RxBool _turnYellow = true.obs;
  bool get turnYellow => _turnYellow.value;

  void _buildBoard() {
    _turnYellow.value = true;
    board = [
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
    ];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _buildBoard();
  }

  void playColumn(int columnNumber) {
    //* Save player number depending on player's turn
    final int playerNumber = turnYellow ? 1 : 2;
    //* Select column
    final selectedColumn = board[columnNumber];

    //* Check if selectedColumn has zeros -> empty cells
    if (selectedColumn.contains(0)) {
      //* Check for first appearance of a zero
      final int rowIndex = selectedColumn.indexWhere((cell) => cell == 0);
      //* Replace zero with playerNumber
      selectedColumn[rowIndex] = playerNumber;
      //* Switch turns
      _turnYellow.value = !_turnYellow.value;
      //* Update UI
      update();

      int resultHorizontal = checkHorizontals();
      int resultVertical = checkVerticals();

      if (resultHorizontal == 1 || resultVertical == 1) {
        Get.defaultDialog(
          title: 'YELLOW WON',
          content: Cell(
            currentCellMode: cellMode.YELLOW,
          ),
        ).then((value) => _buildBoard());
      } else if (resultHorizontal == 2 || resultVertical == 2) {
        Get.defaultDialog(
          title: 'RED WON',
          content: Cell(
            currentCellMode: cellMode.RED,
          ),
        ).then((value) => _buildBoard());
      }
    } else {
      Get.snackbar('Not available',
          'This column is already filled up. Choose another column.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  int checkHorizontals() {
    int yellowInARow = 0;
    int redInARow = 0;
    List<List<int>> rows = [];

    for (var i = 0; i < 6; i++) {
      final List<int> currentRow = getRowList(i);
      rows.add(currentRow);
    }

    for (final row in rows) {
      for (final cell in row) {
        if (yellowInARow >= 4) {
          return 1;
        } else if (redInARow >= 4) {
          return 2;
        } else {
          if (cell == 1) {
            yellowInARow++;
            redInARow = 0;
          } else if (cell == 2) {
            redInARow++;
            yellowInARow = 0;
          } else {
            yellowInARow = 0;
            redInARow = 0;
          }
        }
      }
    }
    return 0;
  }

  List<int> getRowList(int rowNumber) {
    List<int> rowList = [];
    for (final column in board) {
      rowList.add(column[rowNumber]);
    }
    return rowList;
  }

  int checkVerticals() {
    int yellowInARow = 0;
    int redInARow = 0;

    for (final column in board) {
      for (final cell in column) {
        if (yellowInARow >= 4) {
          return 1;
        } else if (redInARow >= 4) {
          return 2;
        } else {
          if (cell == 1) {
            yellowInARow++;
            redInARow = 0;
          } else if (cell == 2) {
            redInARow++;
            yellowInARow = 0;
          } else {
            yellowInARow = 0;
            redInARow = 0;
          }
        }
      }
    }
    return 0;
  }
}

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _initBoard();
  }

  void _initBoard() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _currentPlayer = 'X';
    _gameOver = false;
  }

  void _makeMove(int row, int col) {
    if (!_gameOver && _isValidMove(row, col)) {
      setState(() {
        _board[row][col] = _currentPlayer;
        if (_checkWinner(row, col)) {
          _gameOver = true;
          _showDialog('Player ${_currentPlayer == 'X' ? '1' : '2'} Wins!');
        } else if (_checkDraw()) {
          _gameOver = true;
          _showDialog('It\'s a Draw!');
        }
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X'; // Switch player
      });
    }
  }

  bool _isValidMove(int row, int col) {
    return row >= 0 && row < 3 && col >= 0 && col < 3 && _board[row][col] == '';
  }

  bool _checkWinner(int row, int col) {
    if (!_board.any((row) => row.any((cell) => cell.isNotEmpty))) {
      return false;
    }

    String currentPlayer = _board[row][col]; // Get the current player

    // Check row
    if (_board[row].every((cell) => cell == currentPlayer)) {
      return true;
    }
    // Check column
    if (_board.every((row) => row[col] == currentPlayer)) {
      return true;
    }
    // Check diagonal
    if (row == col) {
      if (_board.every((row) => row[_board.indexOf(row)] == currentPlayer)) {
        return true;
      }
    }
    // Check reverse diagonal
    if (row + col == 2) {
      if (_board
          .every((row) => row[2 - _board.indexOf(row)] == currentPlayer)) {
        return true;
      }
    }
    return false;
  }

  bool _checkDraw() {
    return _board.every((row) => row.every((cell) => cell != ''));
  }

  void _showDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Game Over!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _initBoard();
                });
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildBoardRows(),
            ),
            Visibility(
              visible: _gameOver,
              child: Container(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBoardRows() {
    List<Widget> rows = [];
    for (int i = 0; i < 3; i++) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < 3; j++) {
        rowChildren.add(
          GestureDetector(
            onTap: () => _makeMove(i, j),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: Text(
                  _board[i][j],
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
        );
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      ));
    }
    return rows;
  }
}

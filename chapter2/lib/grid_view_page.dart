import 'package:flutter/material.dart';
import 'dart:math' as math;

class GridViewPage extends StatefulWidget {
  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  int _columnsCount = 2;
  double _textSize = 42;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initStat() {
    _scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${_scrollController.hasClients ? _scrollController.position.pixels.toInt().toString() : 0} pixels'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              if (_columnsCount < 10) {
                setState(() {
                  _columnsCount++;
                  _textSize = 42 * 2 / _columnsCount;
                });
              }
            },
            child: const Icon(
              Icons.grid_on,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              if (_columnsCount > 2) {
                setState(() {
                  _columnsCount--;
                  _textSize = 42 * 2 / _columnsCount;
                });
              }
            },
            child: Icon(
              Icons.grid_off,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                0,
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInQuint,
              );
            },
            child: Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _columnsCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) => Container(
          color: Colors.black,
          child: Center(
            child: Text(
              index.toString(),
              style: TextStyle(
                fontSize: _textSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GridViewPage extends StatefulWidget {
  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => Container(
            color: Colors.black,
            child: Center(
              child: Text(
                index.toString(),
                style: TextStyle( 
                  fontSize: 42,
                  color: Colors.white,
                )
              )
            )
          )
      ),
    );
  }
}

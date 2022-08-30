import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Screen1()));

//スクリーン1
class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen1'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('戻る'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Screen2(),
              ),
            );
          },
        ),
      ),
    );
  }
}

//スクリーン2
class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('次へ'),
        ),
      ),
    );
  }
}

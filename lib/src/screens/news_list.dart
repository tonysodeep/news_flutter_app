import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemBuilder: (context, int index) {
        return FutureBuilder(
          builder: (context, snapshot) {
            return Container(
              height: 80,
              child: snapshot.hasData
                  ? Text('i m visible $index')
                  : Text('i have no data $index'),
            );
          },
          future: getFuture(),
        );
      },
      itemCount: 1000,
    );
  }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'hi',
    );
  }
}

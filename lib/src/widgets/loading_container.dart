import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),

        ),
        Divider(
          height: 8,
        ),
      ],
    );
  }
  Widget buildContainer(){
    return Container(
      color: Colors.grey[200],
      height: 24,
      width: 150,
      margin: EdgeInsets.symmetric(vertical: 2.5),
    );
  }
}

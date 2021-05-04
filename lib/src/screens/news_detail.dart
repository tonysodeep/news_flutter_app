import 'package:flutter/material.dart';
import 'package:news/src/blocs/comment_bloc.dart';
import 'package:news/src/blocs/comment_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;
  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('News Deatail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentBloc bloc) {
    return StreamBuilder(
      builder: (
        context,
        AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot,
      ) {
        if (!snapshot.hasData) return Text('loading');
        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) return Text('Loading');
            return buildList(itemSnapshot.data, snapshot.data);
            // return Text(itemSnapshot.data.title);
          },
          future: itemFuture,
        );
      },
      stream: bloc.itemWithComments,
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));

    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();

    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel itemModel) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10),
      child: Text(
        itemModel.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Center(
                child: LoadingContainer(),
              );
            }
            return buildTile(itemSnapshot.data);
          },
          future: snapshot.data[itemId],
        );
      },
      stream: bloc.items,
    );
  }

  Widget buildTile(ItemModel itemModel) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(itemModel.title),
          subtitle: Text('${itemModel.score} votes'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${itemModel.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}

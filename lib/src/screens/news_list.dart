import 'package:flutter/material.dart';
import 'package:news/src/widgets/news_list_tile.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    //this is bads
    //this is temporary
    bloc.fetchTopIs();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemBuilder: (context, int index) {
            bloc.fecthItem(snapshot.data[index]);
            return NewsListTile(
              itemId: snapshot.data[index],
            );
          },
          itemCount: snapshot.data.length,
        );
      },
      stream: bloc.topIds,
    );
  }
}

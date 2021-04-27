import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    //this is bads
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
          return Text('still waiting on ID');
        }
        return ListView.builder(
          itemBuilder: (context, int index) {
            return Text(snapshot.data[index].toString());
          },
          itemCount: snapshot.data.length,
        );
      },
      stream: bloc.topIds,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/screens/news_detail.dart';
import 'package:news/src/screens/news_list.dart';
import 'blocs/comment_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          StoriesProvider.of(context).fetchTopIs();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          //extrac item id from setting.name
          //and pass to newsdeatail
          //greate place for inisilization
          final commentBloc = CommentProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          commentBloc.fetchItemWithComments(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }
}

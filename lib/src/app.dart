import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';
import 'package:news/src/screens/home_category.dart';
import 'package:news/src/screens/location_screen.dart';
import 'package:news/src/screens/news_detail.dart';
import 'package:news/src/screens/news_list.dart';
import 'blocs/comment_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentProvider(
      child: StoriesProvider(
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  body1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  body2: TextStyle(
                    color: Color.fromRGBO(29, 50, 51, 1),
                  ),
                  title: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                  ),
                ),
          ),
          title: 'News',
          routes: {
            '/': (_) => HomeCategory(),
            '/location': (_) => LocationScreen(),
            '/news': (context) {
              // StoriesProvider.of(context).fetchTopIs();
              return Builder(
                builder: (context) {
                  StoriesProvider.of(context).fetchTopIs();
                  return NewsList();
                },
              );
            },
          },
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        //extrac item id from setting.name
        //and pass to newsdeatail
        //greate place for inisilization
        final commentBloc = CommentProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/news/', ''));
        print(itemId.toString());
        commentBloc.fetchItemWithComments(itemId);
        return NewsDetail(
          itemId: itemId,
        );
      },
    );
  }
}

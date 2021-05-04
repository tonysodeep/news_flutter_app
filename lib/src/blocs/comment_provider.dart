import 'package:flutter/material.dart';
import 'comment_bloc.dart';
export 'comment_bloc.dart';

class CommentProvider extends InheritedWidget {
  
  final CommentBloc commentBloc;
  CommentProvider({Key key, Widget child})
      : commentBloc = CommentBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CommentBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentProvider>())
        .commentBloc;
  }
}

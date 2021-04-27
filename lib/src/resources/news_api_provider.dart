import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:news/src/resources/repository.dart';

import '../models/item_model.dart';

final _root = 'hacker-news.firebaseio.com';

class NewsApiProvider implements Source {
  Client client = Client();

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(
      Uri.http(
        _root,
        'v0/item/$id.json',
      ),
    );
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get(
      Uri.http(
        _root,
        'v0/topstories.json',
      ),
    );
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }
}

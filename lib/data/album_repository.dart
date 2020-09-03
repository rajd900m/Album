import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/album.dart';

class AlbumRepository {
  Future<Album> getAlbumData() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}

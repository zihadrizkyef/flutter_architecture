import 'package:flutter_best_architecture/model/album_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class AlbumsRepo {
  Future<List<Album>> getAlbumList();
}

class AlbumServices implements AlbumsRepo {
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _getAlbums = '/albums';

  @override
  Future<List<Album>> getAlbumList() async {
    Uri uri = Uri.https(_baseUrl, _getAlbums);
    Response response = await http.get(uri);
    List<Album> albums = albumFromJson(response.body);
    return albums;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_best_architecture/events.dart';
import 'package:flutter_best_architecture/repository/services.dart';
import 'package:flutter_best_architecture/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'album_bloc.dart';
import 'model/album_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AlbumsBloc(AlbumServices()),
        child: const AlbumsScreen(),
      ),
    );
  }
}

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  _loadAlbums() async {
    BlocProvider.of<AlbumsBloc>(context).add(FetchAlbums());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (BuildContext context, AlbumsState state) {
          if (state is AlbumsListError) {
            final error = state.error;
            String message = '${error.message}\nTap To Retry';
            return _errorText(message, _loadAlbums);
          }
          if (state is AlbumsLoaded) {
            List<Album> albums = state.albums;
            return _list(albums);
          }
          return const CircularProgressIndicator();
        })
      ],
    );
  }

  _errorText(String message, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }

  _list(List<Album> albums) {
    return Expanded(
      child: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (_, index) {
          Album album = albums[index];
          return Text(album.title + "\n" + album.userId.toString());
        },
      ),
    );
  }
}

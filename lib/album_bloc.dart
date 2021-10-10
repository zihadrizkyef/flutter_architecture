import 'dart:io';

import 'package:flutter_best_architecture/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'model/album_model.dart';
import 'repository/exceptions.dart';
import 'repository/services.dart';

class AlbumsBloc extends Bloc<AlbumsEvents, AlbumsState> {
  final AlbumsRepo albumsRepo;
  List<Album>? albums;

  AlbumsBloc(this.albumsRepo) : super(AlbumsInitState()) {
    on<FetchAlbums>(_onFetchAlbums);
  }

  void _onFetchAlbums(FetchAlbums event, Emitter<AlbumsState> emit) async {
    emit(AlbumsLoading());
    try {
      albums = await albumsRepo.getAlbumList();
      emit(AlbumsLoaded(albums!));
    } on SocketException {
      emit(AlbumsListError(NoInternetException('No Internet')));
    } on HttpException {
      emit(AlbumsListError(NoServiceFoundException('No Service Found')));
    } on FormatException {
      emit(AlbumsListError(InvalidFormatException('Invalid Response format')));
    } catch (e) {
      emit(AlbumsListError(UnknownException('Unknown Error')));
    }
  }
}

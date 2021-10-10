import 'package:equatable/equatable.dart';
import 'package:flutter_best_architecture/repository/exceptions.dart';

import 'model/album_model.dart';

abstract class AlbumsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AlbumsInitState extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;
  AlbumsLoaded(this.albums);
}

class AlbumsListError extends AlbumsState {
  final RepoException error;
  AlbumsListError(this.error);
}
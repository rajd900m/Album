import 'package:album/data/model/album.dart';
import 'package:equatable/equatable.dart';

class AlbumState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AlbumIsNotSearched extends AlbumState {}

class AlbumIsLoading extends AlbumState {}

class AlbumIsLoaded extends AlbumState {
  final _album;

  AlbumIsLoaded(this._album);

  Album get getAlbum => _album;

  @override
  // TODO: implement props
  List<Object> get props => [_album];
}

class AlbumIsNotLoaded extends AlbumState {}
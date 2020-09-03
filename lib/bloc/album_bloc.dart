import 'package:album/data/album_repository.dart';
import 'package:bloc/bloc.dart';
import '../data/model/album.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumRepository albumRepository;

  AlbumBloc(this.albumRepository) : super(AlbumIsNotSearched());

  @override
  Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
    if (event is FetchAlbum) {
      yield AlbumIsLoading();
      try {
        Album album = await albumRepository.getAlbumData();
        yield AlbumIsLoaded(album);
      } catch (_) {
        yield AlbumIsNotLoaded();
      }
    } else if (event is ResetAlbum) {
      yield AlbumIsNotSearched();
    }
  }
}

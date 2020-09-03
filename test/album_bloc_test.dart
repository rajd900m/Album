import 'package:album/bloc/album_bloc.dart';
import 'package:album/bloc/album_event.dart';
import 'package:album/bloc/album_state.dart';
import 'package:album/data/album_repository.dart';
import 'package:album/data/model/album.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAlbumRepository extends Mock implements AlbumRepository {}

void main() {
  MockAlbumRepository mockAlbumRepository;

  setUp(() {
    mockAlbumRepository = MockAlbumRepository();
  });

  group('FetchAlbum', () {

    final album = Album(id: 1, userId: 1, title: "Test Title");

    blocTest(
      'emits [AlbumIsLoading, AlbumIsLoaded] when successful',
      build: () {
        when(mockAlbumRepository.getAlbumData()).thenAnswer((_) async => album);
        return AlbumBloc(mockAlbumRepository);
      },
      act: (bloc) => bloc.add(FetchAlbum()),
      expect: [
        AlbumIsLoading(),
        AlbumIsLoaded(album),
      ]
    );

    blocTest(
        'emits [AlbumIsLoading, AlbumIsLoaded] when successful',
        build: () {
          when(mockAlbumRepository.getAlbumData()).thenThrow(Exception());
          return AlbumBloc(mockAlbumRepository);
        },
        act: (bloc) => bloc.add(FetchAlbum()),
        expect: [
          AlbumIsLoading(),
          AlbumIsNotLoaded(),
        ]
    );

  });


}

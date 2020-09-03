import 'package:album/bloc/album_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/album_event.dart';
import 'bloc/album_state.dart';
import 'data/album_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey,
          body: BlocProvider(
            create: (context) => AlbumBloc(AlbumRepository()),
            child: MyAlbum(),
          ),
        ));
  }
}

class MyAlbum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final albumBloc = BlocProvider.of<AlbumBloc>(context);
    albumBloc.add(FetchAlbum());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumIsLoaded) {
              return Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      state.getAlbum.getTitle,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      state.getAlbum.getUserId.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    )
                  ],
                ),
              );
            } else if (state is AlbumIsLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Text(
                "Error",
                style: TextStyle(color: Colors.white),
              );
            }
          },
        ),
      ],
    );
  }
}

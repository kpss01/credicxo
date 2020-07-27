
import 'package:credicxo/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:credicxo/bloc/bookmarks/bookmarks_event.dart';
import 'package:credicxo/bloc/bookmarks/bookmarks_state.dart';
import 'package:credicxo/bloc/detail/detail_bloc.dart';
import 'package:credicxo/data/api_repository.dart';
import 'package:credicxo/data/api_result_model.dart';
import 'package:credicxo/ui/detailpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarksPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BookmarksPageState();
  }
}

class _BookmarksPageState extends State<BookmarksPage>{

  BookmarksBloc bookmarksBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookmarksBloc=BlocProvider.of<BookmarksBloc>(context);
    bookmarksBloc.add(FetchBookmarksEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double heigth=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Bookmarks',
          style: TextStyle(
              color: Colors.black
          ),),
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: BlocBuilder<BookmarksBloc, BookmarksState>(
          builder: (context, state) {
            if (state is BookmarksInitialState) {
              return buildLoading();
            } else if (state is BookmarksLoadingState) {
              return buildLoading();
            } else if (state is BookmarksLoadedState) {
              return buildSongList(state.list,heigth);
            } else if (state is BookmarksErrorState) {
              return buildErrorUi();
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildSongList(List<Songs> songs, double height) {
    return Container(
      height: height,
      child: ListView.separated(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> BlocProvider(
                      create: (context) => DetailBloc(repository: ApiRepositoryImpl(),song:songs[index]),
                      child: DetailPage(song:songs[index],value: true,))
              ));
            },
            leading: Container(
                width: 50,
                child: Icon(Icons.library_music)),
            title: Text(songs[index].track_name.toString(),
                overflow: TextOverflow.ellipsis),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget buildErrorUi() {
    return Center(child: Text('Something went wrong'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bookmarksBloc.close();
  }
}
import 'package:connectivity/connectivity.dart';
import 'package:credicxo/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:credicxo/ui/bookmarks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo/bloc/detail/detail_bloc.dart';
import 'package:credicxo/bloc/home/song_bloc.dart';
import 'package:credicxo/bloc/home/song_state.dart';
import 'package:credicxo/bloc/home/songs_event.dart';
import 'package:credicxo/data/api_repository.dart';
import 'package:credicxo/data/api_result_model.dart';
import 'package:credicxo/ui/detailpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SongBloc songBloc;
  var subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songBloc = BlocProvider.of<SongBloc>(context);
    getConnectivity();

  }

  void getConnectivity()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      songBloc.add(FetchSongsEvent());
    } else if (connectivityResult == ConnectivityResult.wifi) {
      songBloc.add(FetchSongsEvent());
    }
    else{
      songBloc.add(NoNetworkEvent());
    }

     subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if(result == ConnectivityResult.none){
        songBloc.add(NoNetworkEvent());
      }
      else if(result == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
        if(songBloc.state == NoNetworkState())
        songBloc.add(FetchSongsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Material(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text('Trending',
                style: TextStyle(
                  color: Colors.black
                ),),
                actions: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> BlocProvider(
                              create: (context) => BookmarksBloc(),
                              child: BookmarksPage())
                      ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: 10,left: 5),
                      child: Text('Bookmarks',style: TextStyle(color: Colors.black87),),
                    ),
                  )
                ],
              ),
              body: Container(
                child: BlocBuilder<SongBloc, SongState>(
                  builder: (context, state) {
                    if (state is SongInitialState) {
                      return buildLoading();
                    } else if (state is SongLoadingState) {
                      return buildLoading();
                    } else if (state is SongLoadedState) {
                      return buildSongList(state.songs, height);
                    } else if (state is SongErrorState) {
                      return buildErrorUi(state.message);
                    }
                    else if(state is NoNetworkState){
                      return Center(
                        child: Text('No internet connection'),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ));
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
                      child: DetailPage(song:songs[index],value: false,))
                ));
              },
              leading: Container(
                 width: 50,
                  child: Icon(Icons.library_music)),
              title: Text(songs[index].track_name.toString(),
                  overflow: TextOverflow.ellipsis),
              subtitle: Text(songs[index].album_name.toString(),
                  overflow: TextOverflow.ellipsis),
              trailing: Container(
                width: 80,
                child: Text(songs[index].artist_name.toString(),maxLines: 3,
                    overflow: TextOverflow.ellipsis),
              ),
            );
          },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(child: Text(message));
  }
}

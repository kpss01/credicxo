import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo/bloc/detail/detail_bloc.dart';
import 'package:credicxo/bloc/detail/detail_event.dart';
import 'package:credicxo/bloc/detail/detail_state.dart';
import 'package:credicxo/bloc/home/song_state.dart';
import 'package:credicxo/data/api_result_model.dart';

class DetailPage extends StatefulWidget {
  @override
  Songs song;
  bool value=false;

  DetailPage({this.song,this.value});

  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailBloc detailBloc;
  var subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailBloc = BlocProvider.of<DetailBloc>(context);
    getConnectivity();
  }

  void getConnectivity()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      detailBloc.add(FetchDetailEvent(song: widget.song,value: widget.value));
    } else if (connectivityResult == ConnectivityResult.wifi) {
      detailBloc.add(FetchDetailEvent(song: widget.song,value: widget.value));
    }
    else{
      detailBloc.add(NoNetworkDetailPage());
    }

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if(result == ConnectivityResult.none){
        detailBloc.add(NoNetworkDetailPage());
      }
      else if(result == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
        if(detailBloc.state == NoNetorkStateDetail())
          detailBloc.add(FetchDetailEvent(song: widget.song,value: widget.value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            print(state.toString());
            if (state is DetailInitialState) {
              return buildLoading(height);
            } else if (state is DetailLoadingState) {
              return buildLoading(height);
            } else if (state is DetailLoadedState) {
              widget.song=state.song;
              return buildSongDetail(state.song, height,false);
            } else if (state is DetailErrorState) {
              return buildErrorUi(state.message);
            }
            else if(state is NoNetorkStateDetail){
              return Center(
                child: Text('No internet connection'),
              );
            }
            else if(state is AddBookmarkState){
              return buildSongDetail(state.songs, height,true);
            }
            else if(state is RemoveBookmarkState){
              return buildSongDetail(state.songs, height,false);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildLoading(double height) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Track Detail',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildSongDetail(Songs song, double height,bool bookmark) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Track Detail',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
        actions: [
            !widget.value ? bookmark ? IconButton(
              icon: Icon(Icons.star, color: Colors.yellow[700],),
              onPressed: () {
                detailBloc.add(RemoveBookmark(song));
              },) :
            IconButton(icon: Icon(Icons.star_border, color: Colors.grey,),
              onPressed: () {
                detailBloc.add(AddBookmark(song));
              },):Container()
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Track Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    song.track_name,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Artist Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    song.artist_name.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Album Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),

                  Text(
                    song.album_name.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Explicit',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),

                  Text(
                    "${song.explicit == "0" ? "False" : "True"}",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Rating',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),

                  Text(
                    song.rating.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lyrics',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    song.lyrics.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(child: Text(message));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detailBloc.close();
  }
}

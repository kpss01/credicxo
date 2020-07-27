import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo/bloc/home/song_state.dart';
import 'package:credicxo/bloc/home/songs_event.dart';
import 'package:credicxo/data/api_repository.dart';
import 'package:credicxo/data/api_result_model.dart';

class SongBloc extends Bloc<SongEvent, SongState> {

  SongRepository repository;

  SongBloc({@required this.repository}) : super(SongLoadingState());


  @override
  Stream<SongState> mapEventToState(SongEvent event) async* {
    if (event is FetchSongsEvent) {
      yield SongLoadingState();
      try {
        List<Songs> songs = await repository.getSongs();
        yield SongLoadedState(songs: songs);
      } catch (e) {
        yield SongErrorState(message: e.toString());
      }
    }
    if(event is NoNetworkEvent){
      yield NoNetworkState();
    }
  }
}
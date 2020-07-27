import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo/bloc/detail/detail_event.dart';
import 'package:credicxo/bloc/detail/detail_state.dart';
import 'package:credicxo/data/api_repository.dart';
import 'package:credicxo/data/api_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DetailBloc extends Bloc<DetailEvent, DetailState> {
  Songs song;
  SongRepository repository;

  DetailBloc({@required this.repository,@required this.song}) : super(DetailInitialState());


  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    if(event is FetchDetailEvent){

      yield DetailLoadingState();
      try {

          if(event.value){
            Songs songs=await repository.getSongInfo(event.song.track_id);
            event.song=songs;
          }

          Songs song = await repository.getSongLyric(event.song);
          yield DetailLoadedState(song: song);

          if(sharedPreferences.get(song.track_id)==null){
            yield RemoveBookmarkState(song);
          }
          else{
            yield AddBookmarkState(song);
          }

       } catch (e) {
        yield DetailErrorState(message: e.toString());
      }
    }

    if(event is NoNetworkDetailPage){
      yield NoNetorkStateDetail();
    }

    if(event is AddBookmark){
      sharedPreferences.setString(event.song.track_id, event.song.track_name);
      List<String> list=sharedPreferences.getStringList('bookmarks');
      if(list==null){
        list=List<String>();
      }
      list.add(event.song.track_id);
      sharedPreferences.setStringList('bookmarks', list);
      yield AddBookmarkState(event.song);
    }
    if(event is RemoveBookmark){
      sharedPreferences.remove(event.song.track_id);
      List<String> list=sharedPreferences.getStringList('bookmarks');
      list.remove(event.song.track_id);
      sharedPreferences.setStringList('bookmarks', list);
      yield RemoveBookmarkState(event.song);
    }
  }
}


import 'package:credicxo/bloc/bookmarks/bookmarks_event.dart';
import 'package:credicxo/bloc/bookmarks/bookmarks_state.dart';
import 'package:credicxo/data/api_result_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarksBloc extends Bloc<BookmarksEvent,BookmarksState>{
  BookmarksBloc() : super(BookmarksInitialState());


  @override
  Stream<BookmarksState> mapEventToState(BookmarksEvent event) async*{
    // TODO: implement mapEventToState
    if(event is FetchBookmarksEvent){
      yield BookmarksLoadingState();

      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      List<String> list=sharedPreferences.getStringList('bookmarks');
      if(list==null){
        list=new List<String>();
      }
      List<Songs> bookmarksList=List<Songs>();
      for(int i=0;i<list.length;i++){
        Songs songs=Songs(track_id: list[i],track_name: sharedPreferences.get(list[i]),artist_name: '',album_name: '',rating: '',lyrics: '',explicit: '',album_id: '');
        bookmarksList.add(songs);
      }
      yield BookmarksLoadedState(bookmarksList);
    }
  }



}
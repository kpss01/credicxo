import 'dart:convert';

import 'api_result_model.dart';
import 'package:http/http.dart' as http;

abstract class SongRepository {
  Future<List<Songs>> getSongs();
  Future<Songs> getSongLyric(Songs song);
  Future<Songs> getSongInfo(String id);
}

class ApiRepositoryImpl implements SongRepository {



  @override
  Future<List<Songs>> getSongs() async {
    var response = await http.get("https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=1837bdf1ca1713574cc8ccb91d9bd51d");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Songs>  songs= ApiResultModel.fromJson(data['message']['body']).track_list;
      print("Songs===>${songs.toString()}");
      return songs;
    } else {
      throw Exception();
    }
  }

  @override
  Future <Songs> getSongLyric(Songs song) async{
    var response = await http.get("https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=${song.track_id}&&apikey=1837bdf1ca1713574cc8ccb91d9bd51d");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(response.body.toString());
      song.lyrics= data['message']['body']['lyrics']['lyrics_body'];
      return song;
    } else {
      throw Exception();
    }


  }

  @override
  Future<Songs> getSongInfo(String id) async{
    // TODO: implement getSongInfo
    var response = await http.get("https://api.musixmatch.com/ws/1.1/track.get?track_id=$id&&apikey=1837bdf1ca1713574cc8ccb91d9bd51d");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var map=data['message']['body']['track'];
      Songs songs= Songs(track_id: map['track_id'].toString(),track_name: map['track_name'],album_id: map['album_id'].toString(),album_name: map['album_name'],artist_name: map['artist_name'],explicit: map['explicit'].toString(),lyrics: '',rating: map['track_rating'].toString());
      return songs;
    } else {
      throw Exception();
    }
  }

}
import 'dart:convert';

class ApiResultModel {
  List<Songs> track_list;

  ApiResultModel({ this.track_list});

  ApiResultModel.fromJson(Map<String, dynamic> json) {
    track_list = new List<Songs>();
      json['track_list'].forEach((v) {
        track_list.add(new Songs.fromJson(v));
      });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.track_list!= null) {
      data['articles'] = this.track_list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Songs {
  String track_id;
  String track_name;
  String album_id;
  String album_name;
  String artist_name;
  String rating;
  String explicit;
  String lyrics;
  Songs(
      {this.track_id,this.track_name,this.album_id,this.album_name,this.artist_name,this.rating,this.explicit,this.lyrics});

  Songs.fromJson(Map<String, dynamic> jsonInput) {
    var data=Map<String, dynamic>.from(jsonInput['track']);
    print("songData==>${data.toString()}");
    track_id=data['track_id'].toString();
    track_name=data['track_name'];
    album_name=data['album_name'];
    album_id=data['album_id'].toString();
    artist_name=data['artist_name'];
    rating=data['track_rating'].toString();
    explicit=data['explicit'].toString();
    lyrics='';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['track_id']=track_id;
    json['track_name']=track_name;
    json['album_name']=album_name;
    json['album_id']=album_id;
    json['artist_name']=artist_name;
    return json;
  }
}



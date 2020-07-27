import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:credicxo/data/api_result_model.dart';

abstract class DetailState extends Equatable {}

class DetailInitialState extends DetailState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class DetailLoadingState extends DetailState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DetailLoadedState extends DetailState {
  Songs song;
  DetailLoadedState({@required this.song});

  @override
  // TODO: implement props
  List<Object> get props => [song];
}

class DetailErrorState extends DetailState {
  String message;
  DetailErrorState({@required this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class NoNetorkStateDetail extends DetailState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddBookmarkState extends DetailState{

  Songs songs;
  AddBookmarkState(this.songs);

  @override
  // TODO: implement props
  List<Object> get props => [songs];
}

class RemoveBookmarkState extends DetailState{

  Songs songs;
  RemoveBookmarkState(this.songs);

  @override
  // TODO: implement props
  List<Object> get props => [songs];
}



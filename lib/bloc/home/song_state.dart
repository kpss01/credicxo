import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:credicxo/data/api_result_model.dart';

abstract class SongState extends Equatable {}

class SongInitialState extends SongState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SongLoadingState extends SongState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SongLoadedState extends SongState {
  List<Songs> songs;

  SongLoadedState({@required this.songs});

  @override
  // TODO: implement props
  List<Object> get props => [...songs];
}

class SongErrorState extends SongState {
  String message;

  SongErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class NoNetworkState extends SongState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}


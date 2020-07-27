import 'package:equatable/equatable.dart';
import 'package:credicxo/data/api_result_model.dart';

abstract class SongEvent extends Equatable{}

class FetchSongsEvent extends SongEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class NoNetworkEvent extends SongEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

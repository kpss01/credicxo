import 'package:equatable/equatable.dart';
import 'package:credicxo/data/api_result_model.dart';

abstract class DetailEvent extends Equatable{}

class FetchDetailEvent extends DetailEvent {
  Songs song;
  bool value=false;
  FetchDetailEvent({this.song,this.value});
  @override
  // TODO: implement props
  List<Object> get props =>[song,value];
}

class NoNetworkDetailPage extends DetailEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddBookmark extends DetailEvent{
  final Songs song;

  AddBookmark(this.song);

  @override
  // TODO: implement props
  List<Object> get props => [song];
}

class RemoveBookmark extends DetailEvent{
  final Songs song;

  RemoveBookmark(this.song);

  @override
  // TODO: implement props
  List<Object> get props => [song];
}
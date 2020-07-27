
import 'package:credicxo/data/api_result_model.dart';
import 'package:equatable/equatable.dart';

abstract class BookmarksState extends Equatable {}

class BookmarksInitialState extends BookmarksState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class BookmarksLoadingState extends BookmarksState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BookmarksLoadedState extends BookmarksState {
  List<Songs> list;
  BookmarksLoadedState(this.list);
  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class BookmarksErrorState extends BookmarksState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
import 'package:credicxo_task/models/trendingtracks.dart';
import 'package:credicxo_task/networking/repository.dart';
import 'package:rxdart/rxdart.dart';

//Bloc class for Trending Tracks.
class TrendingTracksBloc {
  final _repository =
      TrendingRepository(); //This repository is a layer between networking and trending BLoC.
  final _tracksFetcher = PublishSubject<TrendingTracks>();

  Stream<TrendingTracks> get allTracks => _tracksFetcher.stream;

  //This method fetch trending tracks from REST API.
  fetchTrendingTracks() async {
    TrendingTracks trendingTracks = await _repository.fetchTrendingTracks();
    _tracksFetcher.sink.add(trendingTracks);
  }

  //This method is used to dispose BLoCStream.
  void dispose() {
    _tracksFetcher.close();
  }
} // BLoC class ends.

//Global object is defined for Trending Tracks BLoC;
final trendingTracksBloc = TrendingTracksBloc();

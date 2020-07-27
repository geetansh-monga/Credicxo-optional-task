import 'package:credicxo_task/models/trendingtracks.dart';
import 'package:credicxo_task/networking/repository.dart';
import 'package:rxdart/rxdart.dart';

class TrendingTracksBloc {
  final _repository = TrendingRepository();
  final _tracksFetcher = PublishSubject<TrendingTracks>();

  Stream<TrendingTracks> get allTracks => _tracksFetcher.stream;

  fetchTrendingTracks() async {
    TrendingTracks trendingTracks = await _repository.fetchTrendingTracks();
    _tracksFetcher.sink.add(trendingTracks);
  }

  void dispose() {
    _tracksFetcher.close();
  }
}

final bloc = TrendingTracksBloc();

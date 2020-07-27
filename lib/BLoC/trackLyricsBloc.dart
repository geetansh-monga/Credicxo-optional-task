import 'package:credicxo_task/networking/repository.dart';
import 'package:credicxo_task/models/trackLyrics.dart';
import 'package:rxdart/rxdart.dart';

class TrackLyricsBloc {
  final _repository = TrackLyricsRepository();
  final _lyricFetcher = PublishSubject<TrackLyrics>();

  Stream<TrackLyrics> get trackLyrics => _lyricFetcher.stream;

  fetchTrackLyrics(String _trackId) async {
    TrackLyrics trackLyrics = await _repository.fetchTrackLyrics(_trackId);
    _lyricFetcher.sink.add(trackLyrics);
  }

  void dispose() {
    _lyricFetcher.close();
  }
}

TrackLyricsBloc trackLyricsBloc = TrackLyricsBloc();

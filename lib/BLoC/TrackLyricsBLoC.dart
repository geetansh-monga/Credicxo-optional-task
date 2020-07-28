import 'package:credicxo_task/networking/repository.dart';
import 'package:credicxo_task/models/trackLyrics.dart';
import 'package:rxdart/rxdart.dart';

//Bloc class for Track's Lyrics.
class TrackLyricsBloc {
  final _repository =
      TrackLyricsRepository(); //This repository is a layer between networking and Lyrics BLoC.
  final _lyricFetcher = PublishSubject<TrackLyrics>();

  Stream<TrackLyrics> get trackLyrics => _lyricFetcher.stream;

  //This method fetch trending track's lyrics from REST API.
  fetchTrackLyrics(String _trackId) async {
    TrackLyrics trackLyrics = await _repository.fetchTrackLyrics(_trackId);
    _lyricFetcher.sink.add(trackLyrics);
  }

  //This method is used to dispose BLoCStream.
  void dispose() {
    _lyricFetcher.close();
  }
} // BLoC class ends.

//Global object is defined for Track Lyrics BLoC;
TrackLyricsBloc trackLyricsBloc = TrackLyricsBloc();

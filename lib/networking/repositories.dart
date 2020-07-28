import 'package:credicxo_task/models/trackDetails.dart';
import 'package:credicxo_task/models/trendingtracks.dart';
import 'package:credicxo_task/models/trackLyrics.dart';
import 'package:credicxo_task/networking/networking.dart';

// Class for repository  of Trending tracks.
class TrendingRepository {
  final NetworkingHelper _helper = NetworkingHelper();

  Future<TrendingTracks> fetchTrendingTracks() => _helper.fetchTrendingTracks();
}

// Class for repository  of Track Details.
class TrackDetailsRepository {
  final NetworkingHelper _helper = NetworkingHelper();

  Future<TrackDetails> fetchTrackDetails(String trackId) =>
      _helper.fetchTrackDetails(trackId);
}

// Class for repository  of Track Lyrics.
class TrackLyricsRepository {
  final NetworkingHelper _helper = NetworkingHelper();

  Future<TrackLyrics> fetchTrackLyrics(String trackId) =>
      _helper.fetchTrackLyrics(trackId);
}

import 'dart:convert';

import 'package:credicxo_task/constants/keys.dart';
import 'package:credicxo_task/models/trackDetails.dart';
import 'package:credicxo_task/models/trackLyrics.dart';
import 'package:credicxo_task/models/trendingtracks.dart';
import 'package:http/http.dart' as http;

class NetworkingHelper {
  Future<TrendingTracks> fetchTrendingTracks() async {
    try {
      http.Response response = await http.Client().get(
          'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=8c27a346480b0c499c93a669ab442605');
      return TrendingTracks.fromJson(json.decode(response.body));
    } catch (e) {
      return e;
    }
  }

  Future<TrackDetails> fetchTrackDetails(String trackId) async {
    try {
      http.Response response = await http.Client().get(
          'https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=$kApiKey');
      return TrackDetails.fromJson(json.decode(response.body));
    } catch (e) {
      return e;
    }
  }

  Future<TrackLyrics> fetchTrackLyrics(String trackId) async {
    try {
      http.Response response = await http.Client().get(
          'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=$kApiKey');
      return TrackLyrics.fromJson(json.decode(response.body));
    } catch (e) {
      return e;
    }
  }
}

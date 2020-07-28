import 'dart:convert';

import 'package:credicxo_task/constants/keys.dart';
import 'package:credicxo_task/models/trackDetails.dart';
import 'package:credicxo_task/models/trackLyrics.dart';
import 'package:credicxo_task/models/trendingtracks.dart';
import 'package:http/http.dart' as http;

//Class for fetching JSON from Musixmatch APIs.
class NetworkingHelper {
  //Method for fetching Trending Tracks.
  Future<TrendingTracks> fetchTrendingTracks() async {
    try {
      http.Response response = await http.Client().get(
          'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$kApiKey');
      return TrendingTracks.fromJson(json.decode(response.body));
    } catch (e) {
      return e;
    }
  }

  //Method for fetching Track Details.
  Future<TrackDetails> fetchTrackDetails(String trackId) async {
    try {
      http.Response response = await http.Client().get(
          'https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=$kApiKey');
      return TrackDetails.fromJson(json.decode(response.body));
    } catch (e) {
      return e;
    }
  }

  //Method for fetching Track Lyrics.
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

import 'package:credicxo_task/BLoC/trackLyricsBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:credicxo_task/BLoC/trackDetailsBloc.dart';
import 'package:credicxo_task/models/trackLyrics.dart';
import 'package:credicxo_task/models/trackDetails.dart';
import 'package:credicxo_task/Widgets/InfoWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:credicxo_task/BLoC/ConnectivityBloc.dart';

class InfoPage extends StatefulWidget {
  final String trackId;
  final String trackName;
  InfoPage({this.trackId, this.trackName});
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  SharedPreferences _prefs;
  bool _isLoaded = false;
  bool _isBookmarked = false;

  getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.get(widget.trackId.toString()) == null) {
      setState(() {
        _isBookmarked = false;
      });
    } else {
      setState(() {
        _isBookmarked = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivityBloc.statusController.stream.listen((event) {
      if (event) {
        trackDetailsBloc.fetchTrackDetails(widget.trackId);
        trackLyricsBloc.fetchTrackLyrics(widget.trackId);
      }
    });
    connectivityBloc.observeConnectivity();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    connectivityBloc.isConnected();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        elevation: 7,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Track Details',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () async {
                print('Bookmark Tapped');
                SharedPreferences prefs = await SharedPreferences.getInstance();
                _isBookmarked
                    ? prefs.remove(widget.trackId)
                    : prefs.setString(
                        widget.trackId.toString(), widget.trackName);
                setState(() {
                  _isBookmarked = !_isBookmarked;
                });
                print(prefs.getKeys().toString());
              },
              child: _isBookmarked
                  ? Icon(Icons.bookmark, color: Colors.black, size: 35)
                  : Icon(Icons.bookmark_border, color: Colors.black, size: 35),
            ),
          ],
        ),
      ),
      body: StreamBuilder<bool>(
          stream: connectivityBloc.statusController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 60, 20),
                      child: ListView(
                        children: [
                          StreamBuilder<TrackDetails>(
                            stream: trackDetailsBloc.trackDetails,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _isLoaded = true;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InfoWidget(
                                      header: 'Name',
                                      content: snapshot
                                          .data.message.body.track.trackName,
                                    ),
                                    InfoWidget(
                                      header: 'Artist',
                                      content: snapshot
                                          .data.message.body.track.artistName,
                                    ),
                                    InfoWidget(
                                      header: 'Album Name',
                                      content: snapshot
                                          .data.message.body.track.albumName,
                                    ),
                                    InfoWidget(
                                      header: 'Explicit',
                                      content: snapshot.data.message.body.track
                                                  .explicit !=
                                              null
                                          ? 'True'
                                          : 'False',
                                    ),
                                    InfoWidget(
                                      header: 'Rating',
                                      content: snapshot
                                          .data.message.body.track.trackRating
                                          .toString(),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                          StreamBuilder<TrackLyrics>(
                            stream: trackLyricsBloc.trackLyrics,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return InfoWidget(
                                    header: 'Lyrics',
                                    content: snapshot
                                        .data.message.body.lyrics.lyricsBody);
                              } else {
                                if (_isLoaded) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Container();
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Text('No Internet Connection'),
                      ),
                    );
            } else {
              return Container();
            }
          }),
    );
  }
}

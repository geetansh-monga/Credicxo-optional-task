import 'package:credicxo_task/BLoC/ConnectivityBloc.dart';
import 'package:credicxo_task/models/trendingtracks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../BLoC/TrendingTracsksBLoC.dart';
import 'package:credicxo_task/screens/details.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //This check weather device's wifi or mobile data is on or off.
    connectivityBLoC.statusController.stream.listen((event) {
      if (event) {
        //This fetches Trending tracks from the api.
        trendingTracksBloc.fetchTrendingTracks();
      }
    });
    connectivityBLoC.observeConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    connectivityBLoC.isConnected();
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        backgroundColor: Colors.white,
        title: Text(
          'Trending',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.book,
          size: 40,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'BookmarksPage');
        },
      ),
      body: StreamBuilder<bool>(
          stream: connectivityBLoC.statusController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data
                  ? StreamBuilder<TrendingTracks>(
                      stream: trendingTracksBloc.allTracks,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: Colors.black54,
                              ),
                            ),
                            itemCount:
                                snapshot.data.message.body.trackList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InfoPage(
                                              trackId: snapshot
                                                  .data
                                                  .message
                                                  .body
                                                  .trackList[index]
                                                  .track
                                                  .trackId
                                                  .toString(),
                                              trackName: snapshot
                                                  .data
                                                  .message
                                                  .body
                                                  .trackList[index]
                                                  .track
                                                  .trackName),
                                        ),
                                      );
                                    },
                                    leading: Icon(Icons.library_music),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.message.body
                                              .trackList[index].track.trackName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.message.body
                                              .trackList[index].track.albumName,
                                        ),
                                      ],
                                    ),
                                    trailing: Container(
                                      width: 100,
                                      child: Text(
                                        snapshot.data.message.body
                                            .trackList[index].track.artistName,
                                      ),
                                    )),
                              );
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
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

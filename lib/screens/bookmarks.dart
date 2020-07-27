import 'package:credicxo_task/constants/FontStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List<String> trackNames = [];
  bool _isLoaded = false;

  getPrefsKeys() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Set<String> keys = _prefs.getKeys();
    for (String key in keys) {
      trackNames.add(_prefs.get(key));
    }
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefsKeys();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'Bookmaks',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoaded ? Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Colors.black54,
            ),
          ),
          itemCount: trackNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                trackNames[index],
                style: kBold,
              ),
            );
          },
        ),
      ) : Center(child: CircularProgressIndicator(),)
    );
  }
}

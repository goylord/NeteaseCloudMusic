import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netease_cloud_music/store/redux_store.dart';
import 'package:netease_cloud_music/utils/request.dart';
import 'package:netease_cloud_music/widgets/sound_item.dart';

class PlayListPage extends StatefulWidget {
  @override
  PlayListPageState createState() => PlayListPageState();
}

class PlayListPageState extends State<PlayListPage> {
  List _soundList = [];
  void getMusicListFromPalylistId() {
    int id = ModalRoute.of(context).settings.arguments;
    GetMusicListByPlaylistId(id: id).then((res) {
      print(res["playlist"]["tracks"]);
      setState(() {
        _soundList = res["playlist"]["tracks"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getMusicListFromPalylistId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("歌曲列表")),
      body: SingleChildScrollView(
        child: Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _soundList.length,
              itemBuilder: (context, index) {
                return SoundItem(
                  title: _soundList[index]["name"],
                  descript: _soundList[index]["ar"][0]["name"],
                  img: _soundList[index]["al"]["picUrl"],
                  id: _soundList[index]["id"],
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: FlatButton(
          child: Icon(Icons.refresh_outlined, color: Colors.white,),
          onPressed: () {
            getMusicListFromPalylistId();
          },
        ),
      ),
    );
  }
}

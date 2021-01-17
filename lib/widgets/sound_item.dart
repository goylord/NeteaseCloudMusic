import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netease_cloud_music/store/redux_store.dart';
import 'package:netease_cloud_music/utils/request.dart';

class SoundItem extends StatelessWidget {
  String descript;
  String title;
  String img;
  int id;
  SoundItem({this.title, this.descript, this.img, this.id});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<playerModel, Function>(converter: (store) {
      return (sound) => store.dispatch(sound);
    }, builder: (context, callback) {
      return new Material(
          child: InkWell(
        onTap: () {
          GetMusicUrlById(id: this.id).then((res) {
            print(res);
            print(res["data"][0]["url"]);
            print(res["data"][0]["url"].replaceAll("http", "https"));
            callback(soundModel(
                url: res["data"][0]["url"].replaceAll("http", "https"),
                cover: this.img,
                name: this.title));
          });
        },
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Image.network(
                  this.img + '?param=50y50',
                  width: 50,
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            this.title.length > 16
                                ? this.title.substring(0, 15) + "..."
                                : this.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          this.descript,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 99, 99, 99)),
                        )
                      ],
                    ))
              ],
            )),
      ));
    });
  }
}

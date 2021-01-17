import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netease_cloud_music/store/redux_store.dart';

class Player extends StatefulWidget {
  @override
  PlayerStatus createState() => PlayerStatus();
}

class PlayerStatus extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            new StoreConnector<playerModel, String>(converter: (store) {
              return store.state.cover;
            }, builder: (context, url) {
              return Container(
                child: Center(
                  child: Image.network(url),
                ),
              );
            }),
            new StoreConnector<playerModel, Map<String, VoidCallback>>(
                converter: (store) {
              return {
                "STOP": () => store.dispatch(PlayActions.STOP),
                "PLAY": () => store.dispatch(PlayActions.PLAY),
                "PAUSE": () => store.dispatch(PlayActions.PAUSE)
              };
            }, builder: (context, callback) {
              return Container(
                  margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          height: 50,
                          onPressed: () {
                            callback["STOP"]();
                          },
                          child: Icon(
                            Icons.stop,
                            color: Colors.white,
                          ),
                          color: Colors.red,
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        FlatButton(
                          height: 50,
                          onPressed: () {
                            callback["PLAY"]();
                          },
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          color: Colors.red,
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        FlatButton(
                          height: 50,
                          onPressed: () {
                            callback["PAUSE"]();
                          },
                          child: Icon(
                            Icons.pause,
                            color: Colors.white,
                          ),
                          color: Colors.red,
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]));
            })
          ],
        ),
      ),
    );
  }
}

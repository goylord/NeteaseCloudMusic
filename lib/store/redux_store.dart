import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum PlayActions {
  PLAY,
  STOP,
  PAUSE,
}

class playerModel {
  String playUrl;
  PlayActions playStatus;
  String cover;
  String playName;
  playerModel({this.playStatus, this.playUrl});
}

class soundModel {
  String url;
  String cover;
  String name;
  soundModel({this.url, this.cover, this.name});
}

AudioPlayer audioPlayer = new AudioPlayer();
playerModel playerRedux(playerModel state, dynamic action) {
  print("调用Store播放器");
  print(action);
  if (action == PlayActions.PLAY) {
    state.playStatus = PlayActions.PLAY;
    audioPlayer.play(state.playUrl);
  } else if (action == PlayActions.STOP) {
    state.playStatus = PlayActions.STOP;
    audioPlayer.stop();
  } else if (action == PlayActions.PAUSE) {
    state.playStatus = PlayActions.PAUSE;
    audioPlayer.pause();
  } else if (action is soundModel){
    if (state.playStatus == PlayActions.PLAY || state.playStatus == PlayActions.STOP) {
      audioPlayer.stop();
      audioPlayer.play(action.url);
      state.playStatus = PlayActions.PLAY;
      state.playName = action.name;
      state.cover = action.cover;
    }
  }
  return state;
}

final store = new Store(playerRedux,
    initialState: playerModel(playStatus: PlayActions.STOP, playUrl: '测试'));

class FlutterReduxApp extends StatelessWidget {
  Widget child;
  FlutterReduxApp({this.child, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(store: store, child: this.child);
  }
}

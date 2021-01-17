import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netease_cloud_music/store/redux_store.dart';
import 'package:netease_cloud_music/utils/request.dart';
import 'package:netease_cloud_music/widgets/playlist_item.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  List playLists = [];
  @override
  void initState() {
    super.initState();
    GetPersonalizedList().then((res) {
      setState(() {
        playLists = res["result"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text("网二云音乐"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 220, 220, 220),
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                    spreadRadius: 2)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Column(
                                // 歌手
                                children: [
                                  Image.asset(
                                    "lib/assets/recommand_hand.png",
                                    width: 50,
                                    height: 50,
                                  ),
                                  Text("推荐歌手")
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                // 最佳歌单
                                children: [
                                  Image.asset("lib/assets/player_red.png",
                                      width: 50, height: 50),
                                  Text("最佳歌单")
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                // 排行
                                children: [
                                  Image.asset("lib/assets/rank.png",
                                      width: 50, height: 50),
                                  Text("歌曲排行")
                                ],
                              )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 220, 220, 220),
                                    offset: Offset(2, 2),
                                    blurRadius: 10,
                                    spreadRadius: 2)
                              ]),
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            "推荐歌单",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 0,
                                          child: Icon(Icons.arrow_right))
                                    ],
                                  )),
                              Divider(),
                              ListView.builder(
                                  controller: _scrollController,
                                  itemCount: playLists.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return PlayListItem(
                                      title: playLists[index]["name"],
                                      img: playLists[index]["picUrl"],
                                      descript: playLists[index]["copywriter"],
                                      id: playLists[index]["id"],
                                    );
                                  })
                            ],
                          ),
                        )
                      ],
                    ))),
          ),
          new StoreConnector<playerModel, Map<String, Object>>(
              converter: (store) {
            return {
              "STATUS": store.state.playStatus,
              "NAME": store.state.playName,
              "COVER": store.state.cover
            };
          }, builder: (context, callback) {
            print(callback["STATUS"]);
            return callback["STATUS"] == PlayActions.PLAY
                ? GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/player");
                    },
                    child: Container(
                      height: 50,
                      width: 500,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top:
                                  BorderSide(width: 1, color: Colors.black12))),
                      child: Row(
                        children: [
                          Image.network(
                            callback["COVER"],
                            width: 40,
                            height: 40,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              callback["NAME"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ))
                : Container();
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: FlatButton(
          child: Icon(
            Icons.refresh_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            GetPersonalizedList().then((res) {
              print(res["result"]);
              setState(() {
                playLists = res["result"];
              });
            });
          },
        ),
      ),
    );
  }
}

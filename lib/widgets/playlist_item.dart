import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayListItem extends StatelessWidget {
  String descript;
  String title;
  String img;
  int id;
  PlayListItem({this.title, this.descript, this.img, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Material(
            child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/playlist", arguments: this.id);
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
    )));
  }
}

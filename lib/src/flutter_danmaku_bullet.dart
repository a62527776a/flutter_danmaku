// 弹幕子弹
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_danmaku/flutter_danmaku.dart';
import 'package:flutter_danmaku/src/config.dart';
import 'package:flutter_danmaku/src/flutter_danmaku_manager.dart';

class FlutterDanmakuBulletModel {
  UniqueKey id;
  UniqueKey trackId;
  Size bulletSize;
  String text;
  double offsetY;
  double runDistance = 0;
  double everyFrameRunDistance = 1;

  double get maxRunDistance => bulletSize.width + FlutterDanmakuConfig.areaSize.width;

  // create time
  final int timestamp = DateTime.now().millisecondsSinceEpoch;

  FlutterDanmakuBulletModel({this.id, this.trackId, this.text, this.bulletSize, this.offsetY, this.everyFrameRunDistance});
}

class FlutterDanmakuBullet extends StatelessWidget {
  FlutterDanmakuBullet(this.danmakuId, this.text);

  String text;
  UniqueKey danmakuId;

  GlobalKey key;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: key,
      style: TextStyle(fontSize: FlutterDanmakuConfig.bulletLableSize, color: Colors.blueGrey),
    );
  }
}

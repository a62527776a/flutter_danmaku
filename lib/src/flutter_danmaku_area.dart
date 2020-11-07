// 弹幕主场景
import 'package:flutter/material.dart';
import 'package:flutter_danmaku/flutter_danmaku.dart';
import 'package:flutter_danmaku/src/config.dart';
import 'package:flutter_danmaku/src/flutter_danmaku_bullet_manager.dart';
import 'package:flutter_danmaku/src/flutter_danmaku_manager.dart';

class FlutterDanmakuArea extends StatefulWidget {
  FlutterDanmakuArea({this.key, @required this.child}) : super(key: key);

  final Widget child;

  final GlobalKey<FlutterDanmakuAreaState> key;

  @override
  State<FlutterDanmakuArea> createState() => FlutterDanmakuAreaState();
}

class FlutterDanmakuAreaState extends State<FlutterDanmakuArea> {
  List<FlutterDanmakuTrack> _tracks = [];
  FlutterDanmakuManager _danmakuManager = FlutterDanmakuManager();

  bool get inited => _inited;
  FlutterDanmakuManager get danmakuManager => _danmakuManager;
  List<FlutterDanmakuTrack> get tracks => _tracks;

  bool _inited = false;

  void _initArea() {
    resizeArea();
    if (_inited) return;
    _inited = true;
    _danmakuManager.run(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
  }

  // 是否暂停
  bool get isPause => FlutterDanmakuConfig.pause;

  // 添加弹幕
  void addDanmaku(String text, {FlutterDanmakuBulletType bulletType = FlutterDanmakuBulletType.scroll, Color color = FlutterDanmakuConfig.defaultColor}) {
    _danmakuManager.addDanmaku(context, text, bulletType: bulletType, color: color);
  }

  // 初始化
  void init() {
    _initArea();
  }

  // 暂停
  void pause() {
    FlutterDanmakuConfig.pause = true;
  }

  // 播放
  void play() {
    FlutterDanmakuConfig.pause = false;
  }

  // 修改弹幕速率
  void changeRate(double rate) {
    assert(rate > 0);
    FlutterDanmakuConfig.bulletRate = rate;
  }

  void changeOpacity(double opacity) {
    assert(opacity <= 1);
    assert(opacity >= 0);
    FlutterDanmakuConfig.opacity = opacity;
  }

  // 修改文字大小
  void changeLableSize(int size) {
    assert(size > 0);
    FlutterDanmakuConfig.bulletLableSize = size.toDouble();
    FlutterDanmakuTrackManager.recountTrackOffset();
    FlutterDanmakuBulletUtils.recountBulletsOffset();
  }

  // 改变视图尺寸后调用，比如全屏
  void resizeArea({Size size = const Size(0, 0)}) {
    FlutterDanmakuConfig.areaSize = context?.size ?? size;
  }

  // 修改弹幕最大可展示场景的百分比
  void changeShowArea(double percent) {
    assert(percent <= 1);
    assert(percent >= 0);
    if (percent < FlutterDanmakuConfig.showAreaPercent) {
      for (int i = 0; i < _tracks.length; i++) {
        // 把溢出的轨道之后全部删掉
        if (FlutterDanmakuTrackManager.isTrackOverflowArea(_tracks[i])) {
          _tracks.removeRange(i, _tracks.length);
          break;
        }
      }
    }
    FlutterDanmakuConfig.showAreaPercent = percent;
  }

  // 销毁前需要调用取消监听器
  void dipose() {
    _danmakuManager.timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: widget.child,
        ),
        ...FlutterDanmakuBulletUtils.buildAllBullet(context)
      ],
    );
  }
}

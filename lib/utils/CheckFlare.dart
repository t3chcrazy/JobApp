import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare_controller.dart';

class CustomFlare extends FlareController {

  int _loopCount = 0;
  ActorAnimation _actor;
  double _duration = 0;

  @override
  void initialize(FlutterActorArtboard artboard) {
    _actor = artboard.getAnimation("Untitled");
  }
  
  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _duration += elapsed;
    if (_duration >= _actor.duration) {
      print("Called when duration less than actor duration");
      _loopCount++;
      if (_loopCount >= 1) {
        _actor.apply(_actor.duration, artboard, 1);
        return false;
      }
      _duration %= _actor.duration;
    }
    _actor.apply(_duration, artboard, 1);
    return true;
  }
  
  
  @override
  void setViewTransform(Mat2D viewTransform) {

  }
  
}
import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget padAll({double padAll = padAll}) {
    return Padding(
      padding: EdgeInsets.all(padAll), 
      child: this,
    );
  }
  Widget padX({double padX = padX}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padX), 
      child: this,
    );
  }
  Widget padY({double padY = padY}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padY), 
      child: this,
    );
  }
  Widget padO({EdgeInsets padOnly = const EdgeInsets.only()}) {
    return Padding(
      padding: padOnly, 
      child: this,
    );
  }
  Widget padOT({double padTop = padY}) {
    return Padding(
      padding: EdgeInsets.only(top: padTop), 
      child: this,
    );
  }
  Widget padOL({double padLeft = padX}) {
    return Padding(
      padding: EdgeInsets.only(top: padLeft), 
      child: this,
    );
  }
  Widget padOR({double padRight = padX}) {
    return Padding(
      padding: EdgeInsets.only(top: padRight), 
      child: this,
    );
  }
  Widget padOB({double padBottom = padY}) {
    return Padding(
      padding: EdgeInsets.only(top: padBottom), 
      child: this,
    );
  }
}

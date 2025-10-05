import 'package:flutter/material.dart';
import 'package:work_timer/core/constants/my_dimention.dart';


// padding extension
extension PaddingExtension on Widget {
  Widget padAll({double? padAll}) {
    return Padding(
      padding: EdgeInsets.all(padAll ?? MyDimension.padAll),
      child: this,
    );
  }

  Widget padX({double? padX}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padX ?? MyDimension.padX),
      child: this,
    );
  }

  Widget padY({double? padY}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padY ?? MyDimension.padY),
      child: this,
    );
  }

  Widget padO({EdgeInsets padOnly = const EdgeInsets.only()}) {
    return Padding(padding: padOnly, child: this);
  }

  Widget padOT({double? padT}) {
    return Padding(
      padding: EdgeInsets.only(top: padT ?? MyDimension.padT),
      child: this,
    );
  }

  Widget padOL({double? padL}) {
    return Padding(
      padding: EdgeInsets.only(left: padL ?? MyDimension.padL),
      child: this,
    );
  }

  Widget padOR({double? padR}) {
    return Padding(
      padding: EdgeInsets.only(right: padR ?? MyDimension.padR),
      child: this,
    );
  }

  Widget padOB({double? padB}) {
    return Padding(
      padding: EdgeInsets.only(bottom: padB ?? MyDimension.padB),
      child: this,
    );
  }
}
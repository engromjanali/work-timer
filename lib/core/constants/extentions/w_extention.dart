import 'package:flutter/material.dart';
import 'package:work_timer/core/constants/my_dimention.dart';


// padding extension
extension PaddingExtension on Widget {
  Widget padAll({double? val}) {
    return Padding(
      padding: EdgeInsets.all(val ?? MyDimension.padAll),
      child: this,
    );
  }

  Widget padX({double? val}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: val ?? MyDimension.padX),
      child: this,
    );
  }

  Widget padY({double? val}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: val ?? MyDimension.padY),
      child: this,
    );
  }

  Widget padO({EdgeInsets val = const EdgeInsets.only()}) {
    return Padding(padding: val, child: this);
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

  Widget padOR({double? val}) {
    return Padding(
      padding: EdgeInsets.only(right: val ?? MyDimension.padR),
      child: this,
    );
  }

  Widget padOB({double? val}) {
    return Padding(
      padding: EdgeInsets.only(bottom: val ?? MyDimension.padB),
      child: this,
    );
  }
}


Widget spaceX({double? val}){
  return SizedBox(
    width: val??10,
  );
}
Widget spaceY(double? val){
  return SizedBox(
    height: val??10,
  );
}
import '/flutter_flow/flutter_flow_util.dart';
import 'home_feed_widget.dart' show HomeFeedWidget;
import 'package:flutter/material.dart';


class HomeFeedModel extends FlutterFlowModel<HomeFeedWidget> {

  bool isEventAdded = false;

  final unfocusNode = FocusNode();
  
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

}

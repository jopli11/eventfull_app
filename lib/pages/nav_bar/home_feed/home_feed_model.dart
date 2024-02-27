
import '/flutter_flow/flutter_flow_util.dart';
import 'home_feed_widget.dart' show HomeFeedWidget;
import 'package:flutter/material.dart';


class HomeFeedModel extends FlutterFlowModel<HomeFeedWidget> {
  ///  Local state fields for this page.

  bool isEventAdded = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - eventCheck] action in ToggleIcon widget.
  bool? eventAdded;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

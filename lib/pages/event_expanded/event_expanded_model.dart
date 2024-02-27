
import '/flutter_flow/flutter_flow_util.dart';
import 'event_expanded_widget.dart' show EventExpandedWidget;
import 'package:flutter/material.dart';

class EventExpandedModel extends FlutterFlowModel<EventExpandedWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - convertGeopointToCity] action in Stack widget.
  String? cityDecode;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;

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

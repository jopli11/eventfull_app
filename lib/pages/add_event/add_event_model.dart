
import '/flutter_flow/flutter_flow_util.dart';
import 'add_event_widget.dart' show AddEventWidget;

import 'package:flutter/material.dart';


class AddEventModel extends FlutterFlowModel<AddEventWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for PlacePicker widget.
  var placePickerValue = const FFPlace();
  // State field(s) for ticketLink widget.
  FocusNode? ticketLinkFocusNode;
  TextEditingController? ticketLinkController;
  String? Function(BuildContext, String?)? ticketLinkControllerValidator;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    ticketLinkFocusNode?.dispose();
    ticketLinkController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

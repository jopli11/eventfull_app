import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'empty_state_dynamic_model.dart';
export 'empty_state_dynamic_model.dart';

class EmptyStateDynamicWidget extends StatefulWidget {
  const EmptyStateDynamicWidget({
    super.key,
    this.icon,
    String? title,
    String? body,
    this.buttonAction,
    String? buttonText,
  })  : title = title ?? 'No Friends',
        body = body ??
            'It seems that you dont\' have  any friends, find friends from searching users below.',
        buttonText = buttonText ?? 'Find Friends';

  final Widget? icon;
  final String title;
  final String body;
  final Future Function()? buttonAction;
  final String buttonText;

  @override
  State<EmptyStateDynamicWidget> createState() =>
      _EmptyStateDynamicWidgetState();
}

class _EmptyStateDynamicWidgetState extends State<EmptyStateDynamicWidget> {
  late EmptyStateDynamicModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyStateDynamicModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, -1.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon!,
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Proxima Nova Final',
                    color: FlutterFlowTheme.of(context).primaryText,
                    useGoogleFonts: false,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
            child: Text(
              widget.body,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Proxima Nova Final',
                    fontWeight: FontWeight.w500,
                    useGoogleFonts: false,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                await widget.buttonAction?.call();
              },
              text: widget.buttonText,
              options: FFButtonOptions(
                height: 44.0,
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: const Color(0xFFED49BB),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Proxima Nova Final',
                      useGoogleFonts: false,
                    ),
                elevation: 3.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
                hoverColor: FlutterFlowTheme.of(context).accent1,
                hoverBorderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 1.0,
                ),
                hoverTextColor: FlutterFlowTheme.of(context).primaryText,
                hoverElevation: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

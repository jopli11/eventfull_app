// ignore_for_file: avoid_print

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'home_feed_model.dart';
export 'home_feed_model.dart';

class HomeFeedWidget extends StatefulWidget {
  const HomeFeedWidget({super.key});

  @override
  State<HomeFeedWidget> createState() => _HomeFeedWidgetState();
}

class _HomeFeedWidgetState extends State<HomeFeedWidget> {
  late HomeFeedModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeFeedModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserEventsRecord>>(
      stream: queryUserEventsRecord(parent: currentUserReference),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _buildLoadingIndicator();
        }
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFFF1F4F8),
            body: _buildBody(context),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: Center(
        child: SizedBox(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Visibility(
      visible: responsiveVisibility(
        context: context,
        tablet: false,
        tabletLandscape: false,
        desktop: false,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildBackgroundContainer(),
            ],
          ),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundContainer() {
    return Container(
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          Container(
            width: 430.0,
            height: 932.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/event_feed_bg.png',
                ).image,
              ),
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Container(
              width: 430.0,
              height: 932.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/Untitled-2_bg.png',
                  ).image,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/event_feed_bg.png'),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/Untitled-2_bg.png'),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          child: StreamBuilder<List<EventsRecord>>(
            stream: queryEventsRecord(
              queryBuilder: (eventsRecord) => eventsRecord.where(
                'StartTime',
                isGreaterThanOrEqualTo: getCurrentTimestamp,
              ),
              limit: 25,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return _buildEventsLoadingIndicator();
              }
              final events =
                  snapshot.data ?? []; // Default to an empty list if null
              return _buildEventsListView(events);
            },
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                0.0, 50.0, 20.0, 0.0), // Adjust top padding here
            child: PopupMenuButton<int>(
              color: const Color.fromARGB(
                  255, 0, 1, 61), // background color of the menu
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Filter by Category",
                    style: TextStyle(color: Colors.white), // text color
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text(
                    "Filter by Date",
                    style: TextStyle(color: Colors.white), // text color
                  ),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text(
                    "Add New Event",
                    style: TextStyle(color: Colors.white), // text color
                  ),
                ),
              ],
              icon: const Icon(
                Icons.menu_rounded,
                color: Color(0xFFED49BB), // icon color
                size: 30.0, // icon size
              ),
              onSelected: (value) {
                switch (value) {
                  case 1:
                    print('Filter by Category selected');
                    break;
                  case 2:
                    print('Filter by Date selected');
                    break;
                  case 3:
                    context.pushNamed('AddEvent');
                    break;
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventsLoadingIndicator() {
    return Center(
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            FlutterFlowTheme.of(context).primary,
          ),
        ),
      ),
    );
  }

  Widget _buildEventsListView(List<EventsRecord> events) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventItem(events[index]);
      },
    );
  }

  Widget _buildEventItem(EventsRecord event) {
    final userEventsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserReference?.id)
        .collection('userEvents');

    return StreamBuilder<DocumentSnapshot>(
      stream: userEventsRef.doc(event.reference.id).snapshots(),
      builder: (context, snapshot) {

        final bool isEventAdded = snapshot.hasData && snapshot.data!.exists;


        return InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            setState(() {});
          },
          child: Stack(
            children: [
              Container(
                height: 525.0,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            'EventExpanded',
                            queryParameters: {
                              'eventID': serializeParam(
                                event.reference,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.network(
                            event.photoUrl,
                            width: 400.0,
                            height: 400.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        15.0,
                        0.0,
                        15.0,
                        0.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              8.0,
                              0.0,
                              0.0,
                            ),
                            child: Text(
                              event.title.maybeHandleOverflow(
                                maxChars: 27,
                                replacement: '…',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Proxima Nova Final',
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        15.0,
                        0.0,
                        15.0,
                        0.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              5.0,
                              0.0,
                              0.0,
                            ),
                            child: FutureBuilder<ApiCallResponse>(
                              future: ReverseGeoCodeCall.call(
                                latlng: functions.parseLatLng(
                                  event.location,
                                ),
                              ),
                              builder: (context, snapshot) {
                                final textReverseGeoCodeResponse =
                                    snapshot.data!;
                                return AutoSizeText(
                                  getJsonField(
                                    textReverseGeoCodeResponse.jsonBody,
                                    r'''$.results[0].formatted_address''',
                                  ).toString().maybeHandleOverflow(
                                        maxChars: 70,
                                        replacement: '…',
                                      ),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Proxima Nova Final',
                                        color: const Color(0xFF57636C),
                                        fontSize: 2.0,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: false,
                                      ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0,
                              5.0,
                              0.0,
                              0.0,
                            ),
                            child: AutoSizeText(
                              dateTimeFormat(
                                'yMMMd',
                                event.startTime!,
                              ).maybeHandleOverflow(
                                maxChars: 70,
                                replacement: '…',
                              ),
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Proxima Nova Final',
                                    color: const Color(0xFF57636C),
                                    fontSize: 2.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          5.0,
                          4.0,
                          0.0,
                          0.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: ToggleIcon(
                                onPressed: () async {
                                  if (isEventAdded) {
                                    // If the event is already added, remove it
                                    await userEventsRef
                                        .doc(event.reference.id)
                                        .delete();
                                  } else {
                                    // If the event is not added, add it
                                    await userEventsRef
                                        .doc(event.reference.id)
                                        .set({
                                      'eventRef': event
                                          .reference, // Store the event document reference
                                      // Add any other necessary fields based on your data model
                                    });
                                  }
                                },
                                value: isEventAdded,
                                onIcon: const Icon(
                                  Icons.favorite_rounded,
                                  color: Color(0xFFED49BB),
                                  size: 24.0,
                                ),
                                offIcon: Icon(
                                  Icons.favorite_border_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                ),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderWidth: 1.0,
                              icon: const Icon(
                                Icons.share_rounded,
                                color: Color(0xFFED49BB),
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderWidth: 1.0,
                              icon: const Icon(
                                Icons.shopping_cart_checkout_rounded,
                                color: Color(0xFFED49BB),
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderWidth: 1.0,
                              icon: const Icon(
                                Icons.navigate_next_rounded,
                                color: Color(0xFFED49BB),
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

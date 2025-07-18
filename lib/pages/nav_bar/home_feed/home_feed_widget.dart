// ignore_for_file: avoid_print

import 'package:share/share.dart';
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
  DateTimeRange? selectedDateRange; // Add this line

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
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          child: StreamBuilder<List<EventsRecord>>(
            stream: queryEventsRecord(
              queryBuilder: (eventsRecord) {
                Query<Object?> query = eventsRecord;
                if (selectedDateRange != null) {
                  query = query
                      .where('StartTime', isGreaterThanOrEqualTo: selectedDateRange!.start)
                      .where('EndTime', isLessThanOrEqualTo: selectedDateRange!.end);
                }
                return query.limit(25);
              },
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return _buildLoadingIndicator();
              }
              final events = snapshot.data ?? [];
              return _buildEventsListView(events);
            },
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 50.0, 20.0, 0.0),
            child: PopupMenuButton<int>(
              color: const Color.fromARGB(255, 0, 1, 61),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text("Filter by Date", style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text("Add New Event", style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text("Clear Filter", style: TextStyle(color: Colors.white)),
                ),
              ],
              icon: const Icon(Icons.menu_rounded, color: Color(0xFFED49BB), size: 30.0),
              onSelected: (value) async {
                if (value == 1) {
                  final DateTimeRange? newRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDateRange: selectedDateRange,
                  );

                  if (newRange != null) {
                    setState(() {
                      selectedDateRange = newRange;
                    });
                  }
                } else if (value == 2) {
                  context.pushNamed('AddEvent');
                } else if (value == 3) {
                  // Clear filter action
                  if (selectedDateRange != null) {
                    setState(() {
                      selectedDateRange = null;
                    });
                  }
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
                              future: PlacesCall.call(
                                  location:
                                      functions.parseLatLng(event.location),
                                  radius:
                                      100, // Example radius, adjust based on your needs
                                  type: 'night_club',
                                  keyword:
                                      'club' // Specifically targeting nightclubs
                                  // keyword parameter is optional and can be omitted unless you have a specific keyword in mind
                                  ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return const Text('Loading...');
                                }

                                final placesResponse = snapshot.data!;

                                // Attempting to get the first result's name as the venue name and vicinity for address.
                                final results = getJsonField(
                                    placesResponse.jsonBody, r'''$.results''');
                                String venueName = results.isNotEmpty
                                    ? results[0]['name']
                                    : '';
                                String vicinity = results.isNotEmpty
                                    ? results[0]['vicinity']
                                    : ''; // Using 'vicinity' for address

                                // Combining venue name with vicinity (address)
                                String displayText = venueName.isNotEmpty
                                    ? "$venueName, $vicinity"
                                    : 'Venue not found';

                                return AutoSizeText(
                                  displayText,
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Proxima Nova Final',
                                        color: const Color(0xFF57636C),
                                        fontSize:
                                            14, // Adjusted font size for visibility
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
                                      'eventID': event
                                          .reference, // Changed from event.reference to event.reference.id
                                      'title': event.title,
                                      'startTime': event.startTime,
                                      'endTime': event.endTime,
                                      'photo_url': event.photoUrl,
                                      'location': GeoPoint(
                                          event.location!.latitude,
                                          event.location!.longitude),
                                      'description': event.description,
                                      'ticketLink': event.ticketLink,
                                      'organiserName': event.organiserName,
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
                              //share button
                              borderColor: Colors.transparent,
                              borderWidth: 1.0,
                              icon: const Icon(
                                Icons.share_rounded,
                                color: Color(0xFFED49BB),
                                size: 24.0,
                              ),
                              onPressed: () async {
                                final Uri url = Uri.parse(
                                    'https://yourapp.link/event/${event.reference.id}');
                                const String msg =
                                    'Check out this event on EventFull. If you don\'t have the app, download it here: [App Download Link]';
                                Share.share('$msg $url');
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
                              onPressed: () async {
                                await launchURL(event.ticketLink);
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

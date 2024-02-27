import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_page_model.dart';
export 'settings_page_model.dart';

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  State<SettingsPageWidget> createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  late SettingsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildMenuItem(String title, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Proxima Nova Final',
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: false,
                    ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFED49BB),
                size: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIconButton(IconData icon, String url) {
    return FlutterFlowIconButton(
      borderRadius: 12.0,
      borderWidth: 1.0,
      buttonSize: 48.0,
      fillColor: const Color(0xFFED49BB),
      icon: FaIcon(
        icon,
        color: FlutterFlowTheme.of(context).primaryBtnText,
        size: 24.0,
      ),
      onPressed: () async {
        try {
          await launchUrl(Uri.parse(url));
        } catch (e) {
          print("Can't load URL: $e");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: 430.0,
            height: 932.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'Settings Page',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Proxima Nova Final',
                          fontSize: 26.0,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts: false,
                        ),
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 0.0),
                    child: Text(
                      'Please evaluate your options below.',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Proxima Nova Final',
                            color: const Color(0x9995A1AC),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: false,
                          ),
                    ),
                  ),
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    _buildMenuItem('Getting Started', ''),
                    _buildMenuItem('About Us', ''),
                    _buildMenuItem('Help', ''),
                    _buildMenuItem('Privacy Policy', ''),
                    _buildMenuItem('Terms & Conditions', ''),
                  ],
                ),
                Opacity(
                  opacity: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 8.0),
                    child: Text(
                      'Follow us on',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Proxima Nova Final',
                            color: const Color(0x9995A1AC),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: false,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      16.0, 4.0, 16.0, 50.0), // Increase bottom padding to 5.0
                  child: Row(
                    children: [
                      _buildSocialIconButton(
                          FontAwesomeIcons.youtube, 'https://www.youtube.com/'),
                      const SizedBox(width:5.0), // Add SizedBox with width 5.0 for spacing between buttons
                      _buildSocialIconButton(FontAwesomeIcons.instagram,
                          'https://www.instagram.com/'),
                      const SizedBox(width:5.0), // Add SizedBox with width 5.0 for spacing between buttons
                      _buildSocialIconButton(FontAwesomeIcons.facebookF,
                          'https://www.facebook.com/'),
                      const SizedBox(width:5.0), // Add SizedBox with width 5.0 for spacing between buttons
                      _buildSocialIconButton(FontAwesomeIcons.linkedinIn,
                          'https://www.linkedin.com/'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      16.0, 0.0, 0.0, 5.0), // Reduce bottom padding to 5.0
                  child: Text(
                    'App Version',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Proxima Nova Final',
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts: false,
                        ),
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        16.0, 4.0, 0.0, 5.0), // Reduce bottom padding to 5.0
                    child: Text(
                      'v0.0.1',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Proxima Nova Final',
                            color: const Color(0x9995A1AC),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: false,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();
                      await authManager.signOut();
                      GoRouter.of(context).clearRedirectLocation();
                      context.goNamedAuth('SignUp', context.mounted);
                    },
                    text: 'Log Out',
                    options: FFButtonOptions(
                      width: 150.0,
                      height: 50.0,
                      color: const Color(0xFFED49BB),
                      textStyle: FlutterFlowTheme.of(context)
                          .labelMedium
                          .override(
                            fontFamily: 'Proxima Nova Final',
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: false,
                          ),
                      elevation: 0.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 60.0, 0.0, 0.0),
            child: FlutterFlowIconButton(
              borderRadius: 30.0,
              buttonSize: 50.0,
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () async {
                context.pushNamed('MyProfile');
              },
            ),
          ),
        ],
      ),
    );
  }
}

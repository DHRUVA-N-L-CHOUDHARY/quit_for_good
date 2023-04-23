import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quit_for_good/utils/Colors.dart';

const channel = "test-channel";
const appId = "f2129cf604b24aeaa1445d95506db990";

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  late final token;

  
  @override
  void initState() {
    super.initState();
    initAgora();
    getAgoraToken();
  }

  getAgoraToken() async {
    var data = await FirebaseFirestore.instance
        .collection('token')
        .doc('agora-temp-token')
        .get();

    setState(() {
      token = data.data()!['token'];
    });
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      options: ChannelMediaOptions(),
      uid: 0,
    );
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 19),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kContrColor,
              size: 30,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Admin',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff01232C),
            Color(0xff001A24),
            Color(0xff096464),
            Color(0xff00131A),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Stack(
                children: [
                  Center(
                    child: _remoteVideo(),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 130,
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          )),
                      child: Center(
                        child: _localUserJoined
                            ? ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                child: AgoraVideoView(
                                  controller: VideoViewController(
                                    rtcEngine: _engine,
                                    canvas: const VideoCanvas(uid: 0),
                                  ),
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: const RtcConnection(channelId: channel),
          ),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      );
    }
  }
}

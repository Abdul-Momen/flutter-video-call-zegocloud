import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 1.1.1 define a navigator key
  final navigatorKey = GlobalKey<NavigatorState>();

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _Id = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call test'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _name,
          ),
          TextField(
            controller: _Id,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  CallPage(
            callID: _Id.text.toString(),
            uName: _name.text.toString(),
            uId: _name.text.toString()+'123',
          )));


        },
        child: Icon(Icons.video_camera_back),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  final String callID;
  final String uName;
  final String uId;

  const CallPage({
    Key? key,
    required this.callID,
    required this.uName,
    required this.uId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1492412333,
      // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: '87604fdd2d018450295e1f18c0bc619506658e2656be467ff1f2d0424ee01714',
      // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: uId,
      userName: uName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (_) => Navigator.of(context).pop(),
    );
  }
}

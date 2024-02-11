import 'dart:convert';

import 'package:chatai/models/response.dart';
import 'package:chatai/presenter/presenter.dart';
import 'package:chatai/screens/chat_message.dart';
import 'package:chatai/screens/no_connection.dart';
import 'package:chatai/utils/api_helper.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:chatai/utils/connectivity_service.dart';
import 'package:chatai/utils/constant.dart';
import 'package:chatai/utils/interface.dart';
import 'package:chatai/utils/interstitial_ads.dart';
import 'package:chatai/utils/shared_pref_helper.dart';
import 'package:chatai/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  String chatMessage = "";

  ChatScreen({this.chatMessage});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    implements Contract, ApiResult {
  final List<ChatMessage> _messages = [];

  Presenter _presenter;
  bool isLoading = false;
  TextToSpeech tts = TextToSpeech();
  bool isSpeechOn = true;
  String responseMessage = "";
  SharedPreferences shared;
  String question = "";
  bool isSpeakingText = false;

  _ChatScreenState() {
    _presenter = new Presenter(this);
  }

  void sendMessage() {
    ChatMessage _message = ChatMessage(
      text: question,
      sender: "user",
    );

    final request = jsonEncode({
      "model": staticVersionWiseResponse.model,
      "max_tokens": staticVersionWiseResponse.max_tokens,
      "prompt": question.toString(),
      "temperature": staticVersionWiseResponse.frequency
    });

    Map<String, String> _header = <String, String>{
      "Authorization": "Bearer " + staticVersionWiseResponse.mainApiToken,
      "Content-Type": "application/json"
    };

    setState(() {
      isLoading = true;
      isSpeakingText = true;
      _presenter.postRequest(EndPointItem.chatGptApi, request, true, _header);
      _messages.insert(0, _message);
    });
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    CommonMethods.configure(context);

    return connectionStatus == ConnectivityStatus.Offline
        ? NoConnectionScreen()
        : _body();
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    callPrefrence();
    super.initState();

    Future.delayed(Duration(seconds: 30), () async {
      InterstitialAdController.clickCountdownAds(() {});
    });
  }

  Future<Function> callPrefrence() async {
    shared = await SharedPreferences.getInstance();
    isSpeechOn =
        SharedPreferencesHelper.getBoolean(SharedPrefKeys.isVoiceOn, shared);
  }

  Widget _body() {
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            AppBar(
              toolbarHeight: 70,
              elevation: 0.8,
              backgroundColor: AppColors.colorWhite,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(Strings.img_bot),
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI BOT",
                          style: TextStyle(
                              color: AppColors.colorBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        Text(
                          "* online",
                          style: TextStyle(
                              color: AppColors.colorGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isSpeechOn ? Icons.volume_up : Icons.volume_off,
                      color: AppColors.colorBlack,
                    ),
                    onPressed: () {
                      setState(() {
                        // isSpeechOn = SharedPreferencesHelper.getBoolean(SharedPrefKeys.isVoiceOn, shared);
                        if (isSpeechOn) {
                          tts.stop();
                          isSpeechOn = false;
                          SharedPreferencesHelper.saveBoolean(
                              SharedPrefKeys.isVoiceOn, false, shared);
                        } else {
                          tts.speak(responseMessage);
                          isSpeechOn = true;
                          SharedPreferencesHelper.saveBoolean(
                              SharedPrefKeys.isVoiceOn, true, shared);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    padding: Vx.m8,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    })),
            if (isLoading) CommonMethods.spinkit,
            const Divider(
              height: 1.0,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: AppColors.colorPrimary,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                    borderRadius: BorderRadius.circular(50)),
                child: _buildTextComposer(),
              ),
            ),
            isBannerVisible()
          ],
        ),
      )),
    );
  }

  final TextEditingController _controllerEt = TextEditingController();

  Widget _buildTextComposer() {
    if (widget.chatMessage.isNotEmpty) {
      _controllerEt.text = widget.chatMessage.toString();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: _controllerEt,
                /*onSubmitted: (value) {
                  setState(() {
                    widget.chatMessage = "";
                    question = _controllerEt.text;
                    _controllerEt.clear();
                    sendMessage();
                  });
                },*/
                decoration:
                    InputDecoration.collapsed(hintText: Strings.send_a_message),
              ),
            ),
          ),
          isSpeakingText
              ? CommonMethods.spinkit
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.chatMessage = "";
                      question = _controllerEt.text;
                      _controllerEt.clear();
                      sendMessage();
                    });
                  },
                  icon: const Icon(Icons.send))
        ],
      ),
    );
  }

  @override
  void onFailed(String message, EndPointItem request) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }

  @override
  void onSuccess(Response response, EndPointItem request) {
    debugPrint(response.choices[0].text);
    ChatMessage _message = ChatMessage(
      text: response.choices[0].text,
      sender: "bot",
      isCompletedText: () {
        setState(() {
          isSpeakingText = false;
        });
      },
    );

    setState(() {
      responseMessage = response.choices[0].text;
      isLoading = false;
      if (isSpeechOn) {
        tts.speak(response.choices[0].text);
      }
      _messages.insert(0, _message);
    });
  }

  @override
  void onSuccessResponse() {}
}

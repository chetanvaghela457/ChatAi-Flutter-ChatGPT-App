import 'dart:convert';

import 'package:chatai/models/response.dart';
import 'package:chatai/presenter/presenter.dart';
import 'package:chatai/screens/no_connection.dart';
import 'package:chatai/utils/api_helper.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/common_alert.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:chatai/utils/connectivity_service.dart';
import 'package:chatai/utils/constant.dart';
import 'package:chatai/utils/interface.dart';
import 'package:chatai/utils/interstitial_ads.dart';
import 'package:chatai/utils/strings.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech/text_to_speech.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements Contract, ApiResult {
  final TextEditingController _controllerEt = TextEditingController();
  final TextEditingController _controllerAnswerEt = TextEditingController();
  bool isIconVisible = false;
  bool enableAnswerField = false;
  TextToSpeech tts = TextToSpeech();
  bool isAnswerSpeakerOn = false;
  bool isQuestionSpeakerOn = false;

  Presenter _presenter;
  bool isLoading = false;

  _HomeScreenState() {
    _presenter = new Presenter(this);
  }

  @override
  void onFailed(String message, EndPointItem request) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onSuccess(Response response, EndPointItem request) {
    setState(() {
      isLoading = false;
      _controllerAnswerEt.text = response.choices[0].text;
    });
  }

  @override
  void onSuccessResponse() {}

  void sendMessage() {
    final request = jsonEncode({
      "model": staticVersionWiseResponse.model,
      "max_tokens": staticVersionWiseResponse.max_tokens,
      "prompt": _controllerEt.text.toString(),
      "temperature": staticVersionWiseResponse.frequency
    });

    Map<String, String> _header = <String, String>{
      "Authorization": "Bearer " + staticVersionWiseResponse.mainApiToken,
      "Content-Type": "application/json"
    };

    setState(() {
      isLoading = true;
      _presenter.postRequest(EndPointItem.chatGptApi, request, true, _header);
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
    super.initState();
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: TextStyle(
          fontSize: 16,
          color: AppColors.colorWhite,
          fontWeight: FontWeight.bold));

  Widget _body() {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                    child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'AI CHAT',
                              style: TextStyle(
                                  color: AppColors.colorPrimary,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //         AnimationPage.createFadeRoute(PremiumScreen()));
                        //   },
                        //   child: Image(
                        //     image: AssetImage(Strings.img_premium),
                        //     width: 40,
                        //     height: 40,
                        //   ),
                        // ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: AppColors.colorPrimary,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: _buildTextComposer(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: CommonMethods.screenWidth - 30,
                          minHeight: 50),
                      child: ElevatedButton(
                        style: style,
                        onPressed: () {
                          InterstitialAdController.clickCountdownAds(() {
                            sendMessage();
                          });
                        },
                        child: const Text('CREATE CONTENT'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: enableAnswerField
                              ? AppColors.colorPrimary
                              : AppColors.colorWhite,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: _textResponseComposer(),
                      ),
                    ),
                    Text(
                      Strings.poweredbyOpenAIGPT,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: CommonMethods.screenHeight * 0.3,
                    )
                  ],
                )),
              ),
            ),
            isBannerVisible()
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    minLines: 5,
                    maxLines: 150,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.colorBlack),
                    controller: _controllerEt,
                    onChanged: (value) {
                      value.isNotEmpty
                          ? setState(() => isIconVisible = true)
                          : setState(() => isIconVisible = false);
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: Strings.ask_anything),
                  ),
                ),
              ),
              isIconVisible
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isIconVisible = false;
                        });
                        _controllerEt.clear();
                      },
                      icon: Icon(
                        CupertinoIcons.clear_circled,
                        color: AppColors.colorPrimary,
                        size: 30,
                      ))
                  : Container()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(_controllerEt.text).then((value) => {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Copied"),
                          ))
                        });
                  },
                  icon: Icon(
                    CupertinoIcons.doc_on_clipboard,
                    color: AppColors.colorPrimary,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    callClipboardDialog();
                  },
                  icon: Icon(
                    CupertinoIcons.paperclip,
                    color: AppColors.colorPrimary,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    share(_controllerEt.text);
                  },
                  icon: Icon(
                    CupertinoIcons.share,
                    color: AppColors.colorPrimary,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (isQuestionSpeakerOn) {
                        isQuestionSpeakerOn = false;
                        tts.stop();
                      } else {
                        isQuestionSpeakerOn = true;
                        isAnswerSpeakerOn = false;
                        tts.speak(_controllerEt.text);
                      }
                    });

                    //
                  },
                  icon: Icon(
                    isQuestionSpeakerOn
                        ? CupertinoIcons.speaker_3_fill
                        : CupertinoIcons.speaker_slash_fill,
                    color: AppColors.colorPrimary,
                    size: 25,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Function callClipboardDialog() {
    CommonAlert.onAlertClipboard(context, "Paste from clipboard", () {
      _getClipboardText();
    });
  }

  Function callClipboardDialogForResponse() {
    CommonAlert.onAlertClipboard(context, "Paste from clipboard", () {
      _getClipboardTextForResponse();
    });
  }

  void _getClipboardTextForResponse() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    setState(() {
      Navigator.of(context).pop();
      _controllerAnswerEt.text = clipboardData?.text;
    });
  }

  void _getClipboardText() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    setState(() {
      Navigator.of(context).pop();
      _controllerEt.text = clipboardData?.text;
    });
  }

  Future<void> share(String text) async {
    await FlutterShare.share(
        title: text, text: text, chooserTitle: 'Share Copied Text');
  }

  Widget _textResponseComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: isLoading
                      ? LottieBuilder.asset(Strings.lottie_message_json,
                          width: 150, height: 150)
                      : TextField(
                          minLines: 5,
                          maxLines: 150,
                          textInputAction: TextInputAction.done,
                          enabled: enableAnswerField ? true : false,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.colorBlack),
                          controller: _controllerAnswerEt,
                          onChanged: (value) {
                            value.isNotEmpty
                                ? setState(() => isIconVisible = true)
                                : setState(() => isIconVisible = false);
                          },
                          decoration:
                              const InputDecoration.collapsed(hintText: ""),
                        ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    if (_controllerAnswerEt.text.isNotEmpty) {
                      FlutterClipboard.copy(_controllerAnswerEt.text)
                          .then((value) => {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Copied"),
                                ))
                              });
                    } else {
                      null;
                    }
                  },
                  icon: Icon(
                    CupertinoIcons.doc_on_clipboard,
                    color: _controllerAnswerEt.text.isNotEmpty
                        ? AppColors.colorPrimary
                        : AppColors.colorGrey,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    callClipboardDialogForResponse();
                  },
                  icon: Icon(
                    CupertinoIcons.paperclip,
                    color: _controllerAnswerEt.text.isNotEmpty
                        ? AppColors.colorPrimary
                        : AppColors.colorGrey,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    if (_controllerAnswerEt.text.isNotEmpty) {
                      share(_controllerAnswerEt.text);
                    } else {
                      null;
                    }
                  },
                  icon: Icon(
                    CupertinoIcons.share,
                    color: _controllerAnswerEt.text.isNotEmpty
                        ? AppColors.colorPrimary
                        : AppColors.colorGrey,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (_controllerAnswerEt.text.isNotEmpty) {
                        if (enableAnswerField) {
                          enableAnswerField = false;
                        } else {
                          enableAnswerField = true;
                        }
                      }
                    });
                  },
                  icon: Icon(
                    MdiIcons.clipboardEdit,
                    color: enableAnswerField
                        ? AppColors.colorPrimary
                        : AppColors.colorGrey,
                    size: 25,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (_controllerAnswerEt.text.isNotEmpty) {
                        if (isAnswerSpeakerOn) {
                          isAnswerSpeakerOn = false;
                          tts.stop();
                        } else {
                          isAnswerSpeakerOn = true;
                          isQuestionSpeakerOn = false;
                          tts.speak(_controllerAnswerEt.text);
                        }
                      } else {
                        tts.stop();
                      }
                    });
                  },
                  icon: Icon(
                    isAnswerSpeakerOn
                        ? CupertinoIcons.speaker_3_fill
                        : CupertinoIcons.speaker_slash_fill,
                    color: _controllerAnswerEt.text.isNotEmpty
                        ? AppColors.colorPrimary
                        : AppColors.colorGrey,
                    size: 25,
                  ))
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }
}

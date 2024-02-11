import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatai/utils/strings.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/app_colors.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage({Key key, this.text, this.sender,this.isCompletedText}) : super(key: key);

  final String text;
  final String sender;
  bool animationFinished = false;
  Function isCompletedText;

  @override
  State<StatefulWidget> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {

  @override
  Widget build(BuildContext context) {
    return widget.sender == "user" ? userMessage(context) : botMessage(context);
  }

  Widget userMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 10, right: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.colorPrimary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: widget.text
                        .trim()
                        .text
                        .xl
                        .white
                        .bodyText1(context)
                        .make()
                        .px8())),
          ),
          const SizedBox(
            width: 8,
          ),
          Image(
            image: AssetImage(Strings.img_receive_user),
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget botMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 10, right: 5, bottom: 10),
      child: Row(
        children: [
          Image(
            image: AssetImage(Strings.img_bot),
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.colorLightGrey,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.animationFinished
                          ? Text(widget.text)
                          : AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText(
                                  widget.text,
                                  textAlign: TextAlign.start,
                                  textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  speed: const Duration(milliseconds: 70),
                                ),
                              ],
                              onFinished: () {
                                setState(() {
                                  widget.animationFinished = true;
                                  widget.isCompletedText();
                                });
                              },
                              totalRepeatCount: 1,
                              repeatForever: false,
                              displayFullTextOnTap: false,
                              stopPauseOnTap: false,
                            ),
                    ),
                    IconButton(
                        onPressed: () {
                          FlutterClipboard.copy(widget.text).then((value) => {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Copied"),
                                ))
                              });
                        },
                        icon: const Icon(Icons.copy_all_rounded))
                  ],
                )),
          )
        ],
      ),
    );
  }
}

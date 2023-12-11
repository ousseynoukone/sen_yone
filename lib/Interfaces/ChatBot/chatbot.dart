import 'package:SenYone/Interfaces/ChatBot/message.dart';
import 'package:SenYone/Interfaces/ChatBot/typing.dart';
import 'package:SenYone/Services/operations_service.dart';
import 'package:flutter/material.dart';
import 'package:SenYone/Interfaces/Line/lines.dart';
import 'package:http/http.dart' as http;
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'dart:convert';
import 'package:getwidget/getwidget.dart';

import '../Home/home.dart';

class chatBot extends StatefulWidget {
  const chatBot({super.key});

  @override
  State<chatBot> createState() => _chatBotState();
}

class _chatBotState extends State<chatBot> with AutomaticKeepAliveClientMixin {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> msgs = [];
  bool isTyping = false;
  showSnackBarFun(context) {
    SnackBar snackBar = SnackBar(
      content: const Text(
          "Votre message ne doit pas dépasser les 100 caractères.",
          style: TextStyle(fontSize: 14)),
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void sendMsg() async {
    String text = controller.text;
    controller.clear();

    if (text.isNotEmpty) {
      setState(() {
        msgs.insert(0, Message(true, text));
        isTyping = true;
      });

      scrollController.animateTo(0.0,
          duration: const Duration(seconds: 1), curve: Curves.easeOut);

      var response = await OpsServices.sendMessageToGpt(
        text,
        List.from(msgs), // Pass the current conversation history
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        if (json.containsKey("choices") &&
            json["choices"].isNotEmpty &&
            json["choices"][0].containsKey("message") &&
            json["choices"][0]["message"].containsKey("content")) {
          setState(() {
            isTyping = false;
            msgs.insert(
              0,
              Message(
                false,
                utf8.decode(
                  latin1.encode(json["choices"][0]["message"]["content"]
                      .toString()
                      .trimLeft()),
                ),
              ),
            );
          });

          scrollController.animateTo(0.0,
              duration: const Duration(seconds: 1), curve: Curves.easeOut);
        } else {
          // Handle unexpected JSON structure
          print("Unexpected JSON structure in the response");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Une erreur interne s'est produite, veuillez réessayer !"),
          ));
        }
      } else {
        // Handle non-200 status codes
        print("Received non-200 status code: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Une erreur s'est produite, veuillez réessayer !"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SenChat",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
        automaticallyImplyLeading: false, // Remove the back button
        // Other AppBar properties and widgets
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(
            color: Theme.of(context)
                .primaryColorLight), // Set the color of the back button to white
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            // InkWell(
            //   onTap: () => sendMsg(),
            //   child: Container(
            //     height: 35,
            //     width: 35,
            //     decoration: BoxDecoration(
            //         color: Theme.of(context).primaryColor,
            //         borderRadius: BorderRadius.circular(30)),
            //     child: const Icon(
            //       Icons.refresh_rounded,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: msgs.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: isTyping && index == 0
                            ? Column(
                                children: [
                                  BubbleNormal(
                                    text: msgs[0].msg,
                                    isSender: true,
                                    color: Theme.of(context).primaryColor,
                                    textStyle: msgs[index].isSender
                                        ? TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorLight)
                                        : TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 4),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TypingIndicator()),
                                  )
                                ],
                              )
                            : BubbleNormal(
                                textStyle: msgs[index].isSender
                                    ? TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight)
                                    : TextStyle(
                                        color: Theme.of(context).primaryColor),
                                text: msgs[index].msg,
                                isSender: msgs[index].isSender,
                                color: msgs[index].isSender
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).focusColor,
                              ));
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextField(
                          autocorrect: true,
                          controller: controller,
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (value) {
                            sendMsg();
                          },
                          textInputAction: TextInputAction.send,
                          showCursor: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Saisir votre message",
                            contentPadding: EdgeInsets.symmetric(vertical: 11),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!isTyping) {
                      if (controller.text.length <= 100) {
                        sendMsg();
                      } else {
                        final scaffoldContext = ScaffoldMessenger.of(context);

                        showSnackBarFun(context);
                      }
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

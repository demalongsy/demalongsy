import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../custom/widget/component.dart';

class ViewComment extends StatefulWidget {
  ViewComment({super.key});

  @override
  State<ViewComment> createState() => _ViewCommentState();
}

class _ViewCommentState extends State<ViewComment>
    with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _messageController = new TextEditingController();
  String _messageInput = '';
  bool _isComposing = false;

  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: C.white,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: C.dark2,
                    size: 16.0,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Poppins(
                    text: "Comments",
                    size: 20,
                    color: C.dark1,
                    fontWeight: FW.bold,
                    letterspacing: 0.64,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            //modified
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  reverse: false,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              Divider(height: 1.0),
              Container(
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(), //modified
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _messageController.clear();
    setState(
      () {
        _isComposing = false;
      },
    );
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(
      () {
        _messages.insert(0, message);
      },
    );
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return Container(
      color: C.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextFormField(
                controller: _messageController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                    _messageInput = text;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Send a message...",
                  hintStyle: const TextStyle(
                    color: C.disableTextfield,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: C.disableField),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: C.infoDefault),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          checkAllSpaces(_messageInput)
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: _isComposing
                        ? () => _handleSubmitted(_messageController.text)
                        : null,
                    child: const Button(
                      text: "Send",
                      fontWeight: FW.bold,
                      color: C.dark2,
                      size: 16,
                      boxColor: C.secondaryDefault,
                      boxHeight: 48,
                      haveBorder: false,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: const Button(
                    text: "Send",
                    fontWeight: FW.bold,
                    color: C.dark2,
                    size: 16,
                    boxColor: C.secondaryPressed,
                    boxHeight: 48,
                    haveBorder: false,
                  ),
                )
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.animationController});
  final String text;
  final String _name = "Kraithong";
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_name),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

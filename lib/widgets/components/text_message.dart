
import 'package:flutter/material.dart';
import 'package:quit_for_good/models/ChatMessage.dart';
double kDefaultPadding = 20;
Color kPrimaryColor = Color.fromARGB(255, 77, 186, 81);
class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Colors.white
          : Colors.black,
        // color: kPrimaryColor.withOpacity(message!.isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: TextStyle(
          color: message!.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}

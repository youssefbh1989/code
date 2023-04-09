import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';




class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageController = TextEditingController();
  String _currentMessage;
  String currentTime = DateFormat.jm().format(DateTime.now());

  final messageList = [
    {
      'message': 'Lorem Ipsum is eit',
      'time': '1:15 pm',
      'isMe': true,
    },
    {
      'message': 'Lorem Ipsum is eit',
      'time': '1:17 pm',
      'isMe': false,
    },
    {
      'message':
      'Lorem Ipsum is simply dummy\ntext of the printing and type of\nindustry',
      'time': '1:20 pm',
      'isMe': true,
    },
    {
      'image': 'assets/hairstyle/hairstyle1.png',
      'time': '1:20 pm',
      'isMe': true,
    },
    {
      'message': 'Lorem',
      'time': '1:25 pm',
      'isMe': false,
    },
    {
      'message': 'Lorem Ipsum is eit',
      'time': '1:25 pm',
      'isMe': false,
    },
    {
      'message':
      'Lorem Ipsum is simply dummy\ntext of the printing and type of\nindustry',
      'time': '1:25 am',
      'isMe': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Sora Jain',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heightSpace,
          heightSpace,
          messagesList(),
          textField(),
        ],
      ),
    );
  }

  messagesList() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        itemCount: messageList.length,
        itemBuilder: (context, index) {
          final item = messageList[index];
          return Row(
            mainAxisAlignment:
            item['isMe'] ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: fixPadding * 2.0),
                padding: const EdgeInsets.all(fixPadding / 2),
                decoration: BoxDecoration(
                  color:
                  item['isMe'] ? primaryColor : greyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(0.1),
                      spreadRadius: 2.5,
                      blurRadius: 2.5,
                    ),
                  ],
                ),
                child: item['message'] == null
                    ? Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(item['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item['message'],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: item['isMe'] ? whiteColor : blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          item['time'].toString(),
                          style: TextStyle(
                            color: item['isMe'] ? whiteColor : blackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  textField() {
    var mes = {
      'message': _currentMessage,
      'isMe': true,
      'time': currentTime,
    };
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _currentMessage = value;
                });
              },
              controller: messageController,
              cursorColor: whiteColor,
              style: white16BoldTextStyle,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(fixPadding),
                hintText: 'Write your message',
                hintStyle: white13MediumTextStyle,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.attach_file,
              size: 15,
              color: whiteColor,
            ),
          ),
          widthSpace,
          widthSpace,
          InkWell(
            onTap: () {
              messageController.clear();
              setState(() {
                messageList.add(mes);
              });
            },
            child: const Icon(
              Icons.send,
              size: 15,
              color: whiteColor,
            ),
          ),
          widthSpace,
          widthSpace,
        ],
      ),
    );
  }
}

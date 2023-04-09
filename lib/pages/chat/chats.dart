

import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'chat.dart';



class Chats extends StatelessWidget {
  Chats({Key key}) : super(key: key);

  final chatList = [
    {
      'image': 'assets/users/user1.png',
      'name': 'Sora Jain',
      'message': 'Lorem Ipsum is simply dummy text',
      'time': '10:45 am',
      'messageCount': '2',
    },
    {
      'image': 'assets/specialists/specialist2.png',
      'name': 'Joya Patel',
      'message': 'Lorem ipsum dolor sit amet.',
      'time': '9:00 am',
      'messageCount': '3',
    },
    {
      'image': 'assets/users/user4.png',
      'name': 'Doe John',
      'message': 'Lorem Ipsum is simply dummy text',
      'time': '8:50 am',
      'messageCount': '2',
    },
    {
      'image': 'assets/users/user5.png',
      'name': 'Tina Jain',
      'message': 'Lorem ipsum dolor sit amet.',
      'time': '8:00 am',
      'messageCount': '1',
    },
    {
      'image': 'assets/users/user6.png',
      'name': 'Aelisha Patel',
      'message': 'Lorem Ipsum is simply dummy text',
      'time': '7:50 am',
      'messageCount': '4',
    },
    {
      'image': 'assets/users/user7.png',
      'name': 'Joya John',
      'message': 'Lorem Ipsum is simply dummy text',
      'time': '6:00 am',
      'messageCount': '2',
    },
    {
      'image': 'assets/users/user8.png',
      'name': 'James Mehta',
      'message': 'Lorem ipsum dolor sit amet.',
      'time': '5:00 am',
      'messageCount': '2',
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
          'Chats',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: chat(),
    );
  }

  chat() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        final item = chatList[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            0,
            fixPadding * 2.0,
            fixPadding,
          ),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  const Chat(),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.only(bottom: fixPadding),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(item['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: whiteColor),
                        ),
                        child: Text(
                          item['messageCount'],
                          style: white10BoldTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                widthSpace,
                widthSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            item['time'],
                            style: grey10SemiBoldTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        item['name'],
                        style: black13SemiBoldTextStyle,
                      ),
                      Text(
                        item['message'],
                        style: black12RegularTextStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

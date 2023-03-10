import 'package:flutter/material.dart';
import 'package:isntagram/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: IconButton(
    //     icon: const Icon(Icons.upload),
    //     onPressed: () {},
    //   ),
    // );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          // back button
          leading: IconButton(
              icon: const Icon(Icons.arrow_back), onPressed: () => {}),
          title: const Text('Post to'),
          centerTitle: false,
          // right bar button
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Post',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1588263390952-f06f1d216880?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1lZGlhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                ),
                SizedBox()
              ],
            )
          ],
        ));
  }
}

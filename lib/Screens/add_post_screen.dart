import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isntagram/Resources/firestor_methods.dart';
import 'package:isntagram/models/user.dart';
import 'package:isntagram/utils/colors.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // holds the selected image
  Uint8List? _file;
  // loading indicator
  bool _isLoading = false;

  // text editing controller
  final TextEditingController _descriptionController = TextEditingController();

  // action to select an image to be posted
  _selectImage(BuildContext context) async {
    // dialog to select image
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              // simple dialog options
              // take a picture with camera option
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  // remove the top most route off the stack
                  Navigator.of(context).pop();
                  // image source is camera
                  Uint8List file = await pickImage(ImageSource.camera);
                  // set the image
                  setState(() {
                    _file = file;
                  });
                },
              ),
              // chose picture from gallery option
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  // remove the top most route off the stack
                  Navigator.of(context).pop();
                  // image source is camera
                  Uint8List file = await pickImage(ImageSource.gallery);
                  // set the image
                  setState(() {
                    _file = file;
                  });
                },
              ),
              // cancel upload option
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  // descriotion controller dispose
  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  // post image action
  void postImage(String uid, String username, String profileImgae) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profileImgae);
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // set image selected to null
  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // state management
    final User user = Provider.of<UserProvider>(context).getUser;

    // return this when we dont have an image and want to upload one
    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () {
                _selectImage(context);
              },
            ),
          )
        // else return this when we have an image and want to upload one
        :
        // return this when we have an image and want to upload one
        Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              // arrow back button
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Post to'),
              centerTitle: false,
              // post image right bar button action
              actions: [
                TextButton(
                  onPressed: () =>
                      postImage(user.uid, user.username, user.photoURL),
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
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // profile image
                    CircleAvatar(
                      // get profile image from firebase
                      backgroundImage: NetworkImage(user.photoURL),
                    ),
                    // post caption
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none,
                          ),
                          maxLines: 8),
                    ),
                    // selected image to be uploaded
                    SizedBox(
                      height: 45,
                      width: 45,
                      // keeps the child dimensions consistent with the parent
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ],
            ),
          );
  }
}

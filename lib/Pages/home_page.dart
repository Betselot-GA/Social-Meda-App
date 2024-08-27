import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/my_drawer.dart';
import 'package:social_media/components/my_post_button.dart';
import 'package:social_media/components/my_textfield.dart';
import 'package:social_media/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // text controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    // only post message if there is something in the textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text("W A L L"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
        ),
        drawer: MyDrawer(),
        body: Column(
          children: [
            // textfield box for user to type
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  // textfield
                  Expanded(
                    child: MyTextfield(
                      hintText: "Say something...",
                      obscureText: false,
                      controller: newPostController,
                    ),
                  ),

                  // post button
                  PostButton(
                    onTap: postMessage,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

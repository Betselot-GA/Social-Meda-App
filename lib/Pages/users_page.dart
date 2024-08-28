import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/my_back_button.dart';
import 'package:social_media/components/my_list_tile.dart';
import 'package:social_media/helper/helper_functions.dart';
import 'package:social_media/services/auth/auth_service.dart';
import 'package:social_media/services/chat/chat_service.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            //any errors
            if (snapshot.hasError) {
              displayMessageToUser("Something went wrong", context);
            }

            //show loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return const Text("No Data");
            }

            //get all users
            final users = snapshot.data!.docs;

            return Column(
              children: [
                // back button
                const Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 25),
                  child: Row(
                    children: [
                      MyBackButton(),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                //list of users in the app
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      // get individual user
                      final user = users[index];

                      // get data from each user
                      String username = user['username'];
                      String email = user['email'];

                      return MyListTile(title: username, subTitle: email);
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList(){
    return StreamBuilder(stream: stream, builder: builder)
  }
}

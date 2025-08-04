import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/colors/colors_manager.dart';
import 'package:note_app/logic/get_note/cubit.dart';
import 'package:note_app/presintation/screens/create_note_screen.dart';
import 'package:note_app/presintation/screens/login_screen.dart';
import 'package:note_app/presintation/widgets/notes_list_view.dart';
import 'package:note_app/presintation/widgets/top_button_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetNoteCubit()..getNotes(),
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        body: Stack(
          children: [
            TopButtonWidget(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 137),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNoteScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 164,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              "Add Note",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 18),
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Container(
                          width: 164,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 34),
                  NotesListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
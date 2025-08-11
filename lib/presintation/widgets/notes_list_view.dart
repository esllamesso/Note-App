import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logic/get_note/cubit.dart';
import 'package:note_app/logic/get_note/state.dart';
import 'package:note_app/presintation/screens/note_screen_details.dart';

import '../../core/colors/colors_manager.dart';

class NotesListView extends StatefulWidget {
  const NotesListView({super.key});

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNoteCubit, GetNoteStates>(
      builder: (context, state) {
        if (state is GetNoteLoadingState){
          return Center(child: CircularProgressIndicator());
        }else if (state is GetNoteSuccessState){
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 9),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> NoteScreenDetails(note: note,)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.marron,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.headLine,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    note.description,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorsManager.light,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${note.createdAt.hour}:${note.createdAt.minute}${note.createdAt.hour >= 12 ? " PM" : " AM"}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorsManager.light,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }else if (state is GetNoteErrorState){
          return Text(state.errorMassage);
        }return SizedBox();

      },
    );
  }
}
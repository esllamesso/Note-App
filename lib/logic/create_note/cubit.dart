import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logic/create_note/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/note_model.dart';

class CreateNote extends Cubit<CreateNoteState> {
  CreateNote() : super(CreateNoteState());

  Future<void> noteCreate(NoteModel note) async {
    emit(CreateNoteLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('notes')
          .add(note.toJson());

      emit(CreateNoteSuccessState());
    } catch (e) {
      emit(CreateNoteErrorState(errorMassage: e.toString()));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logic/get_note/state.dart';

import '../../data/note_model.dart';

class GetNoteCubit extends Cubit<GetNoteStates> {
  GetNoteCubit() : super(GetNoteInitialState());

  Future getNotes() async {
    emit(GetNoteLoadingState());

    try {
      final response = await FirebaseFirestore.instance
          .collection("notes")
          .get();
      print(response);
      final finalResult = response.docs
          .map((doc) => NoteModel.fromJson(doc.data()))
          .toList();
      emit(GetNoteSuccessState(notes: finalResult));
    } catch (e) {
      print("GET NOTE ERROR ===== $e");
      emit(GetNoteErrorState(errorMassage: e.toString()));
    }
  }
}
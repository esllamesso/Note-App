import '../../data/note_model.dart';

class GetNoteStates {}

class GetNoteInitialState extends GetNoteStates {}

class GetNoteLoadingState extends GetNoteStates {}

class GetNoteSuccessState extends GetNoteStates {
  List <NoteModel> notes ;
  GetNoteSuccessState ({required this.notes});
}

class GetNoteErrorState extends GetNoteStates {
  final String errorMassage;

  GetNoteErrorState({required this.errorMassage});
}

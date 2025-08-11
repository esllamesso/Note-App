import 'package:flutter/material.dart';
import 'package:note_app/core/colors/colors_manager.dart';
import 'package:note_app/data/note_model.dart';
import 'package:intl/intl.dart';
import 'package:note_app/presintation/widgets/top_button_widget.dart';

class NoteScreenDetails extends StatefulWidget {
  final NoteModel note;

  const NoteScreenDetails({super.key, required this.note});

  @override
  State<NoteScreenDetails> createState() => _NoteScreenDetailsState();
}

class _NoteScreenDetailsState extends State<NoteScreenDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final note = widget.note;

    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.03,
          size.height * 0.05,
          size.width * 0.03,
          size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopButtonWidget(),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(
                    size.width * 0.03,
                    size.height * 0.05,
                    size.width * 0.03,
                    size.height * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              note.headLine,
                              style:  TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,

                              ),
                            ),
                          ),
                           SizedBox(width: 12),
                          Text(
                            DateFormat('dd MMM yyyy \n hh:mm a').format(note.createdAt),
                            style:  TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                       SizedBox(height: 16),

                      if (note.imageUrl != null && note.imageUrl!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            note.imageUrl!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                       SizedBox(height: size.height * 0.09),

                      Center(
                        child: Text(
                          note.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

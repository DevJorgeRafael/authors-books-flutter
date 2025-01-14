import 'package:authors_books/features/books/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookFormPage extends StatefulWidget {
  final Book? book;
  const BookFormPage({super.key, this.book});

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _literaryGenreController = TextEditingController();
  final _publicationDateController = TextEditingController();
  final _languageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Si se proporciona un libro para edición, precarga los valores en los controladores
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _literaryGenreController.text = widget.book!.literaryGenre;
      _languageController.text = widget.book!.language;

      // Formatear la fecha a DD-MM-YYYY
      final publicationDate = widget.book!.publicationDate;
      final formattedDate = DateFormat('dd-MM-yyyy').format(publicationDate);
      _publicationDateController.text = formattedDate;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Validar y convertir la fecha ingresada
        final inputDate = _publicationDateController.text.trim();
        final dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');

        if (!dateRegex.hasMatch(inputDate)) {
          throw const FormatException(
              'Formato inválido para la fecha. Usa DD-MM-YYYY.');
        }

        // Dividir y reorganizar la fecha a YYYY-MM-DD
        final parts = inputDate.split('-');
        final formattedDate =
            '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';

        // Intentar parsear la fecha
        final parsedDate = DateTime.parse(formattedDate);

        // Crear el libro con la fecha convertida
        final book = Book(
          id: widget.book?.id?? 0,
          title: _titleController.text,
          literaryGenre: _literaryGenreController.text,
          publicationDate: parsedDate,
          language: _languageController.text,
        );
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
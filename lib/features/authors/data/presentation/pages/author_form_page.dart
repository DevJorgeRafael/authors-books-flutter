import 'package:authors_books/features/authors/data/models/author_model.dart';
import 'package:authors_books/features/authors/data/presentation/provider/author_provider.dart';
import 'package:authors_books/shared/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AuthorFormPage extends StatefulWidget {
  final Author? author;

  const AuthorFormPage({super.key, this.author});

  @override
  State<AuthorFormPage> createState() => _AuthorFormPageState();
}

class _AuthorFormPageState extends State<AuthorFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Si se proporciona un autor para edición, precarga los valores en los controladores
    if (widget.author != null) {
      _nameController.text = widget.author!.name;
      _lastnameController.text = widget.author!.lastname;
      
      // Formatear la fecha a DD-MM-YYYY
      final birthDate = widget.author!.birthDate;
      final formattedDate = DateFormat('dd-MM-yyyy').format(birthDate);
      _birthDateController.text = formattedDate;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Validar y convertir la fecha ingresada
        final inputDate = _birthDateController.text.trim();
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

        // Crear el autor con la fecha convertida
        final author = Author(
          id: widget.author?.id ?? 0, // Mantén el ID si estás editando
          name: _nameController.text,
          lastname: _lastnameController.text,
          birthDate: parsedDate,
        );

        // Usa el Provider para crear o actualizar el autor
        final authorProvider =
            Provider.of<AuthorProvider>(context, listen: false);

        if (widget.author == null) {
          // Crear nuevo autor
          await authorProvider.createAuthor(author);
        } else {
          // Actualizar autor existente
          await authorProvider.updateAuthor(author);
        }

        // Navegar a la página principal si se crea/actualiza con éxito
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } catch (e) {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error al procesar el autor: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.author == null ? 'Agregar autor' : 'Editar autor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El apellido es requerido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(
                    labelText: 'Fecha de nacimiento (DD-MM-YYYY)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La fecha de nacimiento es requerida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.author == null ? 'Agregar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

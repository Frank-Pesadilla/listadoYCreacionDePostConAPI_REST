import 'package:flutter/material.dart';
import '../../core/api/api_service.dart';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final api = ApiService();

  @override
  void dispose() {
    _userIdController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submitPost() async {
    if (_formKey.currentState!.validate()) {
      final response = await api.createPost(
        int.parse(_userIdController.text),
        _titleController.text,
        _bodyController.text,
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Post creado correctamente')));
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al crear post')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuevo Post')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'ID de Usuario'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'Mensaje'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submitPost, child: Text('Enviar')),
            ],
          ),
        ),
      ),
    );
  }
}

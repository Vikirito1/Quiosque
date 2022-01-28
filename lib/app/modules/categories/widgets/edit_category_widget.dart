import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/category_model.dart';

class EditCategoryWidget extends StatelessWidget {
  EditCategoryWidget({
    Key? key,
    this.onSave,
    this.onCancel,
    this.category,
  }) : super(key: key) {
    if (category == null) {
      _controller = TextEditingController();
    } else {
      _controller = TextEditingController(text: category!.category);
    }
  }

  final Function()? onSave;
  final Function()? onCancel;
  final CategoryModel? category;
  late final TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16.0,
        30.0,
        16.0,
        50.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            category != null ? 'Editar categoria' : 'Criar categoria',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Categoria',
            ),
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: onCancel,
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: onSave,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

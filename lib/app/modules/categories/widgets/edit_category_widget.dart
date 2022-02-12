import 'package:flutter/material.dart';
import 'package:quiosque/app/core/data/dtos/category_dto.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/core/widgets/custom_text_form_field_widget.dart';

class EditCategoryWidget extends StatefulWidget {
  EditCategoryWidget({
    Key? key,
    this.onSave,
    this.onCancel,
    this.category,
  }) : super(key: key) {
    _formKey = GlobalKey<FormState>();
    if (category == null) {
      _controller = TextEditingController();
    } else {
      _controller = TextEditingController(text: category!.category);
    }
  }

  final void Function(CategoryDTO updatedCategory)? onSave;
  final void Function()? onCancel;
  final CategoryModel? category;
  late final TextEditingController? _controller;
  late final GlobalKey<FormState> _formKey;

  @override
  State<EditCategoryWidget> createState() => _EditCategoryWidgetState();
}

class _EditCategoryWidgetState extends State<EditCategoryWidget> {
  @override
  void dispose() {
    widget._controller!.dispose();
    widget._formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: widget._formKey,
      child: Padding(
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
              widget.category != null ? 'Editar categoria' : 'Criar categoria',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20.0),
            CustomTextFormFieldWidget(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Este campo precisa ser preenchido';
                } else {
                  return null;
                }
              },
              controller: widget._controller,
              labelText: 'Categoria',
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: screenWidth * 0.3,
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    child: const Text('Cancelar'),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      if (widget._formKey.currentState?.validate() ?? false) {
                        final CategoryDTO updatedCategory = CategoryDTO(
                          id: widget.category?.id,
                          category: widget._controller!.text,
                        );
                        widget.onSave?.call(updatedCategory);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

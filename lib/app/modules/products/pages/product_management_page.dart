import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/core/data/dtos/product_dto.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/widgets/cancel_button_widget.dart';
import 'package:quiosque/app/core/widgets/confirmation_dialog_widget.dart';
import 'package:quiosque/app/core/widgets/custom_text_form_field_widget.dart';
import 'package:quiosque/app/modules/products/pages/product_management_controller.dart';

import '../../../core/widgets/confirm_button_widget.dart';

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({Key? key, this.product}) : super(key: key);

  static String route = '/manage';
  final ProductModel? product;

  @override
  _ProductManagementPageState createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  late final ProductManagementController controller;
  late final TextEditingController product$;
  late final TextEditingController price$;
  late final CurrencyTextInputFormatter formatter;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    controller = GetIt.I<ProductManagementController>();
    product$ = TextEditingController();
    price$ = TextEditingController();
    formatter = CurrencyTextInputFormatter(decimalDigits: 2, symbol: 'R\$');
    if (widget.product != null) {
      product$.text = widget.product!.product;
      price$.text = formatter.format(widget.product!.price.toStringAsFixed(2));
      controller.setSelectedCategoryByName(widget.product!.category);
    }
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    price$.dispose();
    product$.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product?.product ?? 'Adicionar produto'),
        actions: widget.product != null
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialogWidget(
                        titleText: 'Remover produto',
                        contentText:
                            'Este processo é irreversível. Deseja mesmo continuar?',
                        onCancelPressed: () => Navigator.pop(context),
                        onConfirmPressed: () {
                          controller.onDeleteButtonPressed(widget.product!);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormFieldWidget(
                controller: product$,
                labelText: 'Produto',
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'O produto precisa de um nome';
                  } else {
                    return null;
                  }
                },
              ),
              CustomTextFormFieldWidget(
                controller: price$,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  formatter,
                ],
                labelText: 'Preço',
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'O produto precisa de um preço';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10.0),
              Observer(
                builder: (context) => DropdownButtonFormField<int>(
                  value: controller.selectedCategoryId,
                  items: controller.allCategories
                      .map(
                        (category) => DropdownMenuItem(
                          child: Text(category.category),
                          value: category.id,
                        ),
                      )
                      .toList(),
                  onChanged: controller.setSelectedCategoryId,
                  hint: const Text('Categoria'),
                  validator: (value) {
                    if (value == null) {
                      return 'O produto precisa de uma categoria';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CancelButtonWidget(
                    onPressed: () => Navigator.pop(context),
                  ),
                  ConfirmButtonWidget(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final ProductDTO productDTO = ProductDTO(
                          id: widget.product?.id,
                          product: product$.text,
                          price: formatter.getUnformattedValue().toDouble(),
                          categoriesId: controller.selectedCategoryId!,
                        );
                        await controller.onConfirmButtonPressed(productDTO);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

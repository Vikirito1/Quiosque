import 'package:flutter/material.dart';

class ExclusionConfirmationDialogWidget extends StatelessWidget {
  const ExclusionConfirmationDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: const Text('Confirmar exclusão?'),
      content: const Text('Este processo é irreversível! Deseja prosseguir?'),
      actions: [
        SizedBox(
          width: screenWidth * .3,
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancelar'),
          ),
        ),
        SizedBox(
          width: screenWidth * .3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Confirmar'),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    );
  }
}

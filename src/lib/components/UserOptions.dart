import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/services/providers/ApiProvider.dart';

class UserOptions extends StatelessWidget{
  const UserOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context){
          return [
            //logout button
            PopupMenuItem(
              value: 'logout',
              child: TextButton.icon(
                onPressed: () => {
                  context.read<ApiProvider>().api = null,
                  Navigator.popUntil(context, (route) => route.isFirst),
                  Navigator.popAndPushNamed(context, '/')
                },
                icon: const Icon(Icons.logout),
                label: const Text('Select Server'),
              ),
            ),
          ];
        },
        icon: const Icon(Icons.person)
    );
  }

}
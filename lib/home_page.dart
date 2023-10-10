import 'package:flutter/material.dart';
import 'package:inngage_plugin/inngage_plugin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POC Flutter SDK'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            _sendEvent(context);
          },
          child: const Text('Enviar evento'),
        ),
      ),
    );
  }

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void _sendEvent(BuildContext context) {
    InngageEvent.sendEvent(
      eventName: 'click_me',
      appToken: '4ea9fe3da3a29119b81a2832806aedd3',
      identifier: 'inngage_teste',
    ).then((result) {
      if (result) {
        _showSnackBar(context, 'Evento enviado com sucesso', Colors.green);
      } else {
        _showSnackBar(context, 'Houve um erro. Tente novamente', Colors.red);
      }
    }).catchError((_) {
      _showSnackBar(context, 'Houve um erro. Tente novamente', Colors.red);
    });
  }
}

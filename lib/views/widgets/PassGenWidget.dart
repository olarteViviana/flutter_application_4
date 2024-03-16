import 'dart:math';

import 'package:flutter/material.dart';

class PassGenWidget extends StatelessWidget {
  const PassGenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de Contraseñas'),
      ),
      body: const PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  Map<String, dynamic> values = {'allow':false,'option_yes_no': ''};
  String generatedPassword = '';
  int passwordLength = 8;
  int selectedCheckboxCount = 0;
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeNumbers = true;
  bool includeSymbols = true;

  void generatePassword(){
    final random = Random();
    const characters = 'abcdefghijklmnopqrstuvwxyz';
    const uppercaseCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_+';

    String allCharacters = characters;
    if (includeUppercase) allCharacters += uppercaseCharacters;
    if (includeNumbers) allCharacters += numbers;
    if (includeSymbols) allCharacters += symbols;

    String password = '';
    for (int i = 0; i < passwordLength; i++){
      password += allCharacters[random.nextInt(allCharacters.length)];
    }

    setState(() {
      generatedPassword = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          height: 100,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                generatedPassword, 
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: generatePassword, icon: const Icon(Icons.refresh)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          height: 500,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPasswordSettings(),
              buildPasswordOptions(),
              passwordOptions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPasswordSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personalizar Contraseña:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Longitud de la Contraseña: $passwordLength'),
        Slider(
          value: passwordLength.toDouble(),
          min: 6,
          max: 20,
          onChanged: (newValue) {
            setState(() {
              passwordLength = newValue.toInt();
            });
          },
        ),
      ],
    );
  }

  Widget buildPasswordOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          title: const Text('Fácil'),
          value: 'easy',
          groupValue: values["option_yes_no"],
          onChanged: (newValue) {
            setState(() {
              values['option_yes_no'] = newValue;
              includeUppercase = true;
              includeLowercase = true;
              includeNumbers = false;
              includeSymbols = false;
            });
          },
        ),
        RadioListTile(
          title: const Text('Todas'),
          value: 'all',
          groupValue: values["option_yes_no"],
          onChanged: (newValue) {
            setState(() {
              values['option_yes_no'] = newValue;
              includeUppercase = true;
              includeLowercase = true;
              includeNumbers = true;
              includeSymbols = true;
            });
          },
        ),
      ],
    );
  }

  Widget passwordOptions() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('Mayúsculas'),
          value: includeUppercase,
          onChanged: (newValue) {
            setState(() {
              includeUppercase = newValue!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Minúsculas'),
          value: includeLowercase,
          onChanged: (newValue) {
            setState(() {
              includeLowercase = newValue!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Números'),
          value: includeNumbers,
          onChanged: (newValue) {
            setState(() {
              includeNumbers = newValue!;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Símbolos'),
          value: includeSymbols,
          onChanged: (newValue) {
            setState(() {
              includeSymbols = newValue!;
            });
          },
        ),
      ],
    );
  }
}
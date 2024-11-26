import 'package:flutter/material.dart';

import '../models/data_converter.dart';
import '../models/length_converter.dart';
import '../models/mass_converter.dart';
import '../models/temperature_converter.dart';

class ConversionScreen extends StatefulWidget {
  final String category;

  ConversionScreen({required this.category});

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String fromUnit = '';
  String toUnit = '';
  String inputValue = ''; // для ввода пользователя
  double resultValue = 0.0;

  TextEditingController inputController = TextEditingController(); // для управления в поле ввода

  void _convert() {
    double value = double.tryParse(inputValue) ?? 0.0;
    double result;

    if (widget.category == 'Данные') {
      result = DataConverter.convert(fromUnit, toUnit, value);
    } else if (widget.category == 'Длина') {
      result = LengthConverter.convert(fromUnit, toUnit, value);
    } else if (widget.category == 'Масса') {
      result = MassConverter.convert(fromUnit, toUnit, value);
    } else if (widget.category == 'Температура') {
      result = TemperatureConverter.convert(fromUnit, toUnit, value);
    } else {
      result = 0.0;
    }

    setState(() {
      resultValue = result;
    });
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        inputValue = "";
      } else if (buttonText == "⌫") {
        inputValue = inputValue.isNotEmpty ? inputValue.substring(0, inputValue.length - 1) : "";
      } else {
        inputValue += buttonText;
      }
      inputController.text = inputValue;
    });
  }

  void _swapUnits() {
    setState(() {
      String temp = fromUnit;
      fromUnit = toUnit;
      toUnit = temp;
    });
  }

  @override
  Widget build(BuildContext context) { 
    List<String> units = [];

    if (widget.category == 'Данные') {
      units = ['Байт', 'КБ', 'МБ', 'ГБ', 'ТБ'];
    } else if (widget.category == 'Длина') {
      units = ['м', 'см', 'км', 'миля', 'морская миля'];
    } else if (widget.category == 'Масса') {
      units = ['кг', 'г', 'карат'];
    } else if (widget.category == 'Температура') {
      units = ['Цельсий', 'Фаренгейт', 'Кельвин'];
    }

    if (!units.contains(fromUnit)) {
      fromUnit = units[0];
    }

    if (!units.contains(toUnit)) {
      toUnit = units[1];
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Конвертация: ${widget.category}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            // Поле ввода с клавиатурой
            TextField(
              controller: inputController,
              decoration: InputDecoration(labelText: 'Введите значение'),
              readOnly: true,
            ),
            SizedBox(height: 10),

            // Блок для выбора единиц измерения
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: fromUnit,
                  onChanged: (value) {
                    setState(() {
                      fromUnit = value!;
                    });
                  },
                  items: units.map((unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: _swapUnits,
                ),
                DropdownButton<String>(
                  value: toUnit,
                  onChanged: (value) {
                    setState(() {
                      toUnit = value!;
                    });
                  },
                  items: units.map((unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 15),

            // Кнопки
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 13,
                itemBuilder: (context, index) {
                  List<String> buttons = [
                    '1', '2', '3', 'AC', '4', '5', '6', '⌫', '7', '8', '9', '.', '0'
                  ];

                  String buttonText = buttons[index];

                  return ElevatedButton(
                    onPressed: () {
                      buttonPressed(buttonText);
                      _convert();
                    },
                    child: Text(buttonText, style: TextStyle(fontSize: 24)),
                  );
                },
              ),
            ),
            SizedBox(height: 15),

            // ElevatedButton(
            //   onPressed: _convert,
            //   child: Text('Конвертировать'),
            // ),
            Text('Результат: $resultValue'),
          ],
        ),
      ),
    );
  }
}

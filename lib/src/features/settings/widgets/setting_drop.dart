import 'package:flutter/material.dart';

class SettingDropTile extends StatelessWidget {
  final String title;
  final String info;
  final String? value;
  final Function(String?) fun;
  final List<String> languages;
  const SettingDropTile({
    Key? key,
    required this.title,
    required this.info,
    required this.value,
    required this.fun,
    required this.languages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(info),
      trailing: Transform.scale(
          scale: 1,
          child: DropdownButton<String>(
            value: value,
            onChanged: (String? newValue) => fun(newValue),
            items: languages.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
    );
  }
}

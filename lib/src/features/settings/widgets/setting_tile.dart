import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String info;
  final bool value;
  final Function(bool) fun;
  const SettingTile({
    super.key,
    required this.title,
    required this.info,
    required this.value,
    required this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(info),
      trailing: Transform.scale(
        scale: 1,
        child: Switch(
          onChanged: (value) => fun(value),
          value: value,
          activeColor: Colors.orange,
          activeTrackColor:
              value ? Color.fromARGB(255, 236, 210, 177) : Colors.red,
          inactiveThumbColor: const Color.fromARGB(255, 31, 32, 32),
          inactiveTrackColor: const Color.fromARGB(255, 253, 250, 250),
        ),
      ),
    );
  }
}

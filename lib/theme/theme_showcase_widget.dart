import 'package:flutter/material.dart';

class ThemeShowcaseWidget extends StatelessWidget {
  const ThemeShowcaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => print('ha'),
          child: const Text('ElevatedButton'),
        ),

        ElevatedButton(
          onPressed: () => print('ha'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          child: const Text('Secondary ElevatedButton'),
        ),
        ElevatedButton(
          onPressed: () => print('ha'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onTertiary,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
          child: const Text('Tertiary ElevatedButton'),
        ),
        ElevatedButton(
          onPressed: () => print('ha'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          child: const Text('ElevatedButton'),
        ),

        //filled button
        FilledButton(
          onPressed: () => print('ha'),
          child: const Text('FilledButton'),
        ),

        //outlined button
        OutlinedButton(
          onPressed: () => print('ha'),
          child: const Text('OutlinedButton'),
        ),

        //text button
        TextButton(
          onPressed: () => print('ha'),
          child: const Text('TextButton'),
        ),
      ],
    );
  }
}

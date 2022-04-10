import 'package:flutter/material.dart';

class AfficheDate extends StatefulWidget {
  const AfficheDate({Key? key}) : super(key: key);

  @override
  State<AfficheDate> createState() => _AfficheDateState();
}

class _AfficheDateState extends State<AfficheDate> {
  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Picker"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: montrerDate,
              child: Text((date == null)
                  ? "Appuyer ici"
                  : date.toString().split(" ").first),
              style: ButtonStyle(
                elevation: MaterialStateProperty.resolveWith((states) => 10),
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.grey),
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.black87),
              ),
            ),
            TextButton(
              onPressed: montrerHeure,
              child:
                  Text((time == null) ? "Appuyer ici" : time!.format(context)),
              style: ButtonStyle(
                elevation: MaterialStateProperty.resolveWith((states) => 10),
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.grey),
                foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> montrerDate() async {
    DateTime? choix = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (choix != null) {
      setState(() {
        date = choix;
      });
    }
  }

  Future<void> montrerHeure() async {
    TimeOfDay? heure =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (heure != null) {
      setState(() {
        time = heure;
      });
    }
  }
}

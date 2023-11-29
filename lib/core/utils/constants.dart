// - Au moins une lettre majuscule- Au moins une lettre minuscule - Au moins un chiffre - Au moins un caractère spéciaux (!@#\$&*~%) - Au moin 8 caractères
import 'package:flutter/material.dart';

final RegExp passwordValidationRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%]).{8,}$');
const textfieldCheckTime = 600;

const Color themeLightBlueColor = Color.fromARGB(255, 0, 162, 186);
const Color themeBlueColor = Color.fromARGB(255, 33, 114, 139);
const Color themeDarkColor = Color.fromARGB(255, 0, 47, 67);
const Color themeLightColor = Colors.white;
const Color themeDisabledButtonColor = Color.fromARGB(255, 217, 217, 217);
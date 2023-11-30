// - Au moins une lettre majuscule- Au moins une lettre minuscule - Au moins un chiffre - Au moins un caractère spéciaux (!@#\$&*~%) - Au moin 8 caractères
import 'package:flutter/material.dart';

final RegExp passwordValidationRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%]).{8,}$');
const textfieldCheckTime = 600;


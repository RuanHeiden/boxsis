
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


var maskCNPJ = new MaskTextInputFormatter(mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
var maskCPF = new MaskTextInputFormatter(mask: '###.###.###-##.', filter: {"#": RegExp(r'[0-9]')});
var maskTelefone = new MaskTextInputFormatter(mask: '+55 ## #####-####', filter: {"#": RegExp(r'[0-9]')});
var maskData = new MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

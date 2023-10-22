import 'package:ti_bank/custom_theme.dart';
import 'package:ti_bank/data/models/income.dart';
import 'package:ti_bank/screens/add_income_screen/widgets/add_income_button.dart';
import 'package:ti_bank/screens/add_income_screen/widgets/add_income_text_field.dart';
import 'package:ti_bank/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AddIncomeScreenArgs {
  const AddIncomeScreenArgs({this.income, required this.source});
  final Income? income;
  final IncomeSource source;
}

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({
    super.key,
    this.income,
    required this.source,
  });

  /// If we are editting income we get here income to edit
  /// If we are creating new income we will get null here
  final Income? income;
  final IncomeSource source;
  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final TextEditingController _summController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController d1 = TextEditingController();
  final TextEditingController d2 = TextEditingController();

  final FocusNode _summFocusNode = FocusNode();
  final FocusNode _descFocusNode = FocusNode();
  final FocusNode _d1 = FocusNode();
  final FocusNode _d2 = FocusNode();

  final ValueNotifier<bool> buttonEnabledNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _summController.addListener(
      () {
        final summValue = int.tryParse(_summController.text) ?? 0;

        if (summValue > 0) {
          buttonEnabledNotifier.value = true;
        } else {
          buttonEnabledNotifier.value = false;
        }
      },
    );

    _summController.text =
        widget.income == null ? '' : widget.income!.amount.toString();
    _descController.text =
        widget.income == null ? '' : widget.income!.description.toString();
  }

  @override
  void dispose() {
    _summController.dispose();
    _descController.dispose();
    buttonEnabledNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: _onBackArrowTap,
                    child: const Icon(
                      Icons.arrow_back,
                      color: CustomTheme.whiteColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'ДОБАВИТЬ ДОХОД',
                    style: context.textTheme.displayMedium
                        ?.copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AddIncomeTextField(
                controller: _summController,
                focusNode: _summFocusNode,
                autofocus: true,
                hintText: 'Сумма дохода',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              const SizedBox(height: 20),
              AddIncomeTextField(
                controller: _descController,
                focusNode: _descFocusNode,
                hintText: 'Описание',
              ),
              const SizedBox(height: 20),
              AddIncomeTextField(
                controller: d1,
                focusNode: _d1,
                hintText: 'Ежемесячные начисления',
              ),
              const SizedBox(height: 20),
              AddIncomeTextField(
                controller: d2,
                focusNode: _d2,
                hintText: 'Процентная ставка',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AddIncomeButton(
        buttonEnabledNotifier: buttonEnabledNotifier,
        onTap: _onAddIncomeTap,
        title: widget.income == null ? 'Добавить доход' : 'Редактировать',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onBackArrowTap() => context.pop();

  void _onAddIncomeTap() {
    final summValue = int.tryParse(_summController.text) ?? 0;
    if (summValue == 0) return;
    final income = Income(
      amount: summValue,
      description: _descController.text,
      source: widget.source,
    );

    context.pop(income);
  }
}

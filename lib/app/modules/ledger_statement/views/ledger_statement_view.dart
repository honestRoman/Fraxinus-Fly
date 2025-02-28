import 'package:flutter/gestures.dart';
import 'package:fraxinusfly/app/commons/all.dart';
import 'package:fraxinusfly/app/data/common_widget/common_button.dart';
import 'package:fraxinusfly/app/data/common_widget/common_textfeild.dart';
import 'package:gap/gap.dart';

import '../controllers/ledger_statement_controller.dart';

class LedgerStatementView extends GetView<LedgerStatementController> {
  const LedgerStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LedgerStatementController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.ledgerStatement,
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              CommonTextField(
                borderRadius: 12,
                controller: controller.fromDateController,
                title: AppString.fromDate,
                isTitle: true,
                maxLength: 10,
                inputFormatters: [
                  DateInputFormatter(),
                ],
                suffix: GestureDetector(
                  onTap: () {
                    controller.selectDate(context, "from");
                  },
                  child: Icon(Icons.calendar_month),
                ),
              ),
              Gap(15),
              CommonTextField(
                borderRadius: 12,
                controller: controller.toDateController,
                title: AppString.toDate,
                isTitle: true,
                maxLength: 10,
                inputFormatters: [
                  DateInputFormatter(),
                ],
                suffix: GestureDetector(
                  onTap: () {
                    controller.selectDate(context, "to");
                  },
                  child: Icon(Icons.calendar_month),
                ),
              ),
              Gap(15),
              CommonTextField(
                borderRadius: 12,
                controller: controller.ledgerController,
                title: AppString.ledger,
                isTitle: true,
                maxLength: 10,
                hintText: "Please Select...",
                showCursor: false,
                readOnly: true,
                onTap: () {
                  controller.selectLedger();
                },
                suffix: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )),
              ),
              Gap(20),
              if (controller.ledgerList.isNotEmpty)
                CommonButton(
                  btnName: AppString.downloadPdf,
                  onTap: () {
                    controller.genaratePDFApi();
                  },
                ),
              Gap(20),
              tableView(),
            ],
          ),
        );
      },
    );
  }

  Widget tableView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      child: DataTable(
        border: TableBorder.all(),
        columns: const <DataColumn>[
          DataColumn(label: Text('GLDATE')),
          DataColumn(label: Text('DESCRIPTION')),
          DataColumn(label: Text('ACCOUNT')),
          DataColumn(label: Text('TRANSACTION')),
          DataColumn(label: Text('TRANSCHANNEL')),
          DataColumn(label: Text('SRNO')),
          DataColumn(label: Text('CR')),
          DataColumn(label: Text('DR')),
          DataColumn(label: Text('REMARK')),
          DataColumn(label: Text('BALANCE')),
        ],
        rows: List.generate(
          controller.ledgerList.length,
          (index) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(controller.ledgerList[index].glDate ?? "")),
                DataCell(Text(controller.ledgerList[index].description ?? "")),
                DataCell(Text(controller.ledgerList[index].account ?? "")),
                DataCell(Text(controller.ledgerList[index].transaction ?? "")),
                DataCell(Text(controller.ledgerList[index].transChannel ?? "")),
                DataCell(Text(controller.ledgerList[index].serialNumber ?? "")),
                DataCell(Text(controller.ledgerList[index].cr.toString())),
                DataCell(Text(controller.ledgerList[index].dr.toString())),
                DataCell(Text(controller.ledgerList[index].remarks ?? "")),
                DataCell(Text(controller.ledgerList[index].balance ?? "")),
              ],
            );
          },
        ),
      ),
    );
  }
}

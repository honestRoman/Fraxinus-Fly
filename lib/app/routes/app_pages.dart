import 'package:get/get.dart';

import '../modules/bottom_bar/bindings/bottom_bar_binding.dart';
import '../modules/bottom_bar/views/bottom_bar_view.dart';
import '../modules/company_code/bindings/company_code_binding.dart';
import '../modules/company_code/views/company_code_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/item_list/bindings/item_list_binding.dart';
import '../modules/item_list/views/item_list_view.dart';
import '../modules/ledger_statement/bindings/ledger_statement_binding.dart';
import '../modules/ledger_statement/views/ledger_statement_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/outstanding/bindings/outstanding_binding.dart';
import '../modules/outstanding/views/outstanding_view.dart';
import '../modules/pdf_view/bindings/pdf_view_binding.dart';
import '../modules/pdf_view/views/pdf_view_view.dart';
import '../modules/purchase_register/bindings/purchase_register_binding.dart';
import '../modules/purchase_register/views/purchase_register_view.dart';
import '../modules/quotation/bindings/quotation_binding.dart';
import '../modules/quotation/views/quotation_view.dart';
import '../modules/sale_invoice/bindings/sale_invoice_binding.dart';
import '../modules/sale_invoice/views/sale_invoice_view.dart';
import '../modules/sale_register/bindings/sale_register_binding.dart';
import '../modules/sale_register/views/sale_register_view.dart';
import '../modules/sales_order/bindings/sales_order_binding.dart';
import '../modules/sales_order/views/sales_order_view.dart';
import '../modules/show_report/bindings/show_report_binding.dart';
import '../modules/show_report/views/show_report_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY_CODE,
      page: () => const CompanyCodeView(),
      binding: CompanyCodeBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => const BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.LEDGER_STATEMENT,
      page: () => const LedgerStatementView(),
      binding: LedgerStatementBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_REPORT,
      page: () => const ShowReportView(),
      binding: ShowReportBinding(),
    ),
    GetPage(
      name: _Paths.SALE_REGISTER,
      page: () => const SaleRegisterView(),
      binding: SaleRegisterBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE_REGISTER,
      page: () => const PurchaseRegisterView(),
      binding: PurchaseRegisterBinding(),
    ),
    GetPage(
      name: _Paths.OUTSTANDING,
      page: () => const OutstandingView(),
      binding: OutstandingBinding(),
    ),
    GetPage(
      name: _Paths.ITEM_LIST,
      page: () => const ItemListView(),
      binding: ItemListBinding(),
    ),
    GetPage(
      name: _Paths.QUOTATION,
      page: () => const QuotationView(),
      binding: QuotationBinding(),
    ),
    GetPage(
      name: _Paths.SALES_ORDER,
      page: () => const SalesOrderView(),
      binding: SalesOrderBinding(),
    ),
    GetPage(
      name: _Paths.SALE_INVOICE,
      page: () => const SaleInvoiceView(),
      binding: SaleInvoiceBinding(),
    ),
    GetPage(
      name: _Paths.PDF_VIEW,
      page: () => const PdfViewView(),
      binding: PdfViewBinding(),
    ),
  ];
}

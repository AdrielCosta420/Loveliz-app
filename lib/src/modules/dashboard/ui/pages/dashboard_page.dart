import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveliz_app/src/core/routes/app_routes.dart';
import 'package:loveliz_app/src/injectable.dart';
import 'package:loveliz_app/src/modules/sales/domain/usecases/get_sales_uc.dart';
import 'package:loveliz_app/src/modules/sales/ui/controllers/sale_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../common/functions/price_format.dart';
import '../../../../common/functions/mask_date.dart';
import '../../../../common/widgets/app_bar_main_widget.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../../core/providers/app_navigator.dart';
import '../../../../core/services/read_qr_code.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../sales/domain/usecases/get_last_sale_uc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = injector.get<SaleController>();
  final auth = injector.get<AuthController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      injector.get<GetSalesUc>().call();
      injector.get<GetLastSaleUc>().call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: const AppBarMainWidget(
        pageName: 'Dashboard',
        title: 'Olá, Alexia!',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Hoje ',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: [
                  TextSpan(
                    text: MaskDate.toAbbreviationForMonth(DateTime.now()),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListenableBuilder(
                    listenable: controller,
                    builder: (_, _) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child:
                              controller.isLoading
                                  ? const LoadingWidget()
                                  : Column(
                                    children: [
                                      Text(
                                        'Vendas total: ',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                      ),
                                      Text(
                                        '${controller.totalSales}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListenableBuilder(
                    listenable: controller,
                    builder: (_, _) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child:
                              controller.isLoading
                                  ? const LoadingWidget()
                                  : Column(
                                    children: [
                                      Text(
                                        'Total vendido:',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                      ),
                                      Text(
                                        PriceFormat.format(
                                          controller.totalPrice,
                                        ),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Última Venda:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),

            ListenableBuilder(
              listenable: controller,
              builder: (_, _) {
                return controller.isLastSaleLoading
                    ? const LoadingWidget()
                    : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              FontAwesomeIcons.bagShopping,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  controller.lastSale.product.model,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                Text(
                                  PriceFormat.format(
                                    controller.lastSale.totalPrice,
                                  ),

                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 4),
                                Text(
                                  MaskDate.toAbbreviationForMonth(
                                    controller.lastSale.createdAt,
                                  ),
                                  style:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.copyWith(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
              },
            ),
            const SizedBox(height: 24),
            // const Spacer(),
            GestureDetector(
              onTap: () async {
                await readQrCode();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        // Opções de frases mais simples e práticas:
                        // 'Escaneie para registrar venda',
                        // 'Toque para escanear produto',
                        // 'Escaneie e venda rápido',
                        // 'Escanear para nova venda',
                        // 'Toque para vender agora',
                        // 'Registrar venda via QR Code',
                        // 'Escanear código do produto',
                        'Registrar venda via QR Code',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/images/qrcode.png',
                    width: 70,
                    height: 70,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'ou',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed:
                      () => AppNavigator.navigateTo(AppRoutes.registerSale),

                  child: const Text('Registrar nova venda'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

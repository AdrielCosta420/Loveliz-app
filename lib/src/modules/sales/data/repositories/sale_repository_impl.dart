import '../../../../common/result/result.dart';

import '../../domain/errors/sale_error.dart';

import '../../domain/models/sale.dart';

import '../../../../injectable.dart';
import '../../domain/repositories/sale_repository.dart';
import '../service/sale_service.dart';

class SaleRepositoryImpl implements SaleRepository {
  final service = injector.get<SaleService>();

  @override
  Future<Result<SaleError, List<Sale>>> getSales() async {
    try {
      final response = await service.getSales();
      final List<Sale> sales = [];
      for (var sale in response) {
        sales.add(Sale.fromMap(sale));
      }
      return Result.success(sales);
    } on SaleError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(SaleError(e.toString()));
    }
  }

  @override
  Future<Result<SaleError, Sale>> registerSale({required Sale sale}) async {
    try {
      final response = await service.registerSale(sale: sale.toMap());
      return Result.success(Sale.fromMap(response.values as Map<String, dynamic>));
    } on SaleError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(SaleError(e.toString()));
    }
  }
  
  @override
  Future<Result<SaleError, List<Sale>>> getLastSales() async {
    try {
      final response = await service.getLastSales();
      final List<Sale> sales = [];
      for (var sale in response) {
        sales.add(Sale.fromMap(sale));
      }
      return Result.success(sales);
    } on SaleError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(SaleError(e.toString()));
    }
  }
  
  @override
  Future<Result<SaleError, Sale>> getSaleById({required String id}) async {
    try {
      final response = await service.getSaleById(id: id);
      return Result.success(Sale.fromMap(response));
    } on SaleError catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(SaleError(e.toString()));
    }
  }
}

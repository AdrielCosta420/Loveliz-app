import '../../../../common/result/result.dart';
import '../errors/sale_error.dart';
import '../models/sale.dart';

abstract interface class SaleRepository {
  Future<Result<SaleError, List<Sale>>> getSales();
  Future<Result<SaleError, Sale>> registerSale({required Sale sale});
  Future<Result<SaleError, List<Sale>>> getLastSales();
  Future<Result<SaleError, Sale>> getSaleById({required String id});
}
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  void report(
      {required int itemId,
      required String reason,
      required String item,
      required String type}) async {
    emit(ReportLoading());

    try {
      await dioClient.post(
        "/core/report/create/",
        data: {
          'item_id': itemId,
          'reason': "Reason: " + reason,
          'item': item,
          'type': type
        },
      );
      emit(ReportSuccess());
    } on DioException catch (e) {
      emit(ReportError(
          message:
              e.response?.data['error'].toString() ?? "Something went wrong"));
    } catch (e) {
      emit(ReportError(message: "Something went wrong"));
    }
  }
}

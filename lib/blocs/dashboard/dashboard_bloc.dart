import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardPageLoadingState());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadDashboardEvent) {
      try {
        final String jsonString =
            await rootBundle.loadString('assets/data/products.json');
        final Map<String, dynamic> dashboardData = json.decode(jsonString);
        yield DashboardPageLoadedState(dashboardData);
      } catch (e) {
        yield DashboardPageErrorState('Error loading data');
      }
    }
  }
}

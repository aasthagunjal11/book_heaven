abstract class DashboardState {}

class DashboardPageLoadingState extends DashboardState {}

class DashboardPageLoadedState extends DashboardState {
  final Map<String, dynamic> dashboardData;

  DashboardPageLoadedState(this.dashboardData);
}

class DashboardPageErrorState extends DashboardState {
  final String error;

  DashboardPageErrorState(this.error);
}

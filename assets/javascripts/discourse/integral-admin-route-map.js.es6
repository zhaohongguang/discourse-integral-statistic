export default {
  resource: 'admin',
  map() {
    this.route('adminUserIntegrals', { path: 'users-integrals', resetNamespace: true });
    this.route('adminUserIntegralsList', { path: 'user/:user_id/integral-records', resetNamespace: true });
    // this.route('adminUserIntegralNew', { path: 'user/:user_id/integral-record/new', resetNamespace: true });
  }
};
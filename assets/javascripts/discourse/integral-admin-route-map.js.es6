export default {
  resource: 'admin',
  map() {
    this.route('adminUserIntegrals', { path: 'users-integrals', resetNamespace: true });
    this.route('adminUserIntegralsList', { path: 'user/:user_id/integrals', resetNamespace: true });
  }
};
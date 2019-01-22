import AdminUser from "admin/models/admin-user";

export default Discourse.Route.extend({
  model: function(params) {
    this.userFilter = params.filter;
    return AdminUser.findAll(params.filter, { show_emails: true });
  },

  setupController: function(controller, model) {
    controller.setProperties({
      model: model,
      query: this.userFilter,
      showEmails: true,
      refreshing: false
    });
  }
});

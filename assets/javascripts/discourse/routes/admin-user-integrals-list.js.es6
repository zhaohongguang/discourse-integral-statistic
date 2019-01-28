import UserIntegral from '../models/user-integral';
import showModal from "discourse/lib/show-modal";

export default Discourse.Route.extend({
  model: function(params) {
    this.user_id = params.user_id
    return UserIntegral.findAll(params.user_id, { });
  },

  setupController: function(controller, model) {
    controller.setProperties({
      model: model,
      user_id: this.user_id,
    });
  },

  actions: {
    showCreateModal() {
      showModal("admin-create-integral-record", { admin: true });
    }
  }
});
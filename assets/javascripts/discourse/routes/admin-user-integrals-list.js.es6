import UserIntegral from '../models/user-integral';
import showModal from "discourse/lib/show-modal";

export default Discourse.Route.extend({
  model: function(params) {
    return UserIntegral.find(params.user_id, { });
  },

  actions: {
    showCreateModal() {
      showModal("admin-create-integral-record", { admin: true });
    }
  }
});
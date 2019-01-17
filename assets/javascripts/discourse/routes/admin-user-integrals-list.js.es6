import UserIntegral from '../models/user-integral';

export default Discourse.Route.extend({
  model: function(params) {
    return UserIntegral.find(params.user_id, { });
  }
});
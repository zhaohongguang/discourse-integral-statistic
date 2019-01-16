import UserIntegral from '../models/user-integral';
import { ajax } from 'discourse/lib/ajax';

export default Discourse.Route.extend({
  model: function(params) {
    return UserIntegral.find(params.user_id, { });
  }
});
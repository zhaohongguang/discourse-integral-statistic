import UserIntegral from '../models/user-integral';
import { ajax } from 'discourse/lib/ajax';
import AdminUser from "admin/models/admin-user";

export default Discourse.Route.extend({
  model: function(params) {
    console.log(params);
    return this.store.findRecord('post', params.user_id);
  }
});
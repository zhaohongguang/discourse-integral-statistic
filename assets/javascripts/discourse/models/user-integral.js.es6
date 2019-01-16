import { ajax } from 'discourse/lib/ajax';

const UserIntegral = Discourse.Model.extend({
  
});

UserIntegral.reopenClass({
  find(user_id, filter) {
    return ajax("/admin/user/" + user_id + "/integral-records.json", {
      data: filter
    }).then(function(records) {
      return records.map(r => UserIntegral.create(r));
    });
  }
});

export default UserIntegral;
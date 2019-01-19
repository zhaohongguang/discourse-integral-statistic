import UserIntegral from '../models/user-integral';
import debounce from "discourse/lib/debounce";
import { default as computed } from "ember-addons/ember-computed-decorators";
import { i18n } from "discourse/lib/computed";
import { observes } from "ember-addons/ember-computed-decorators";

export default Ember.Controller.extend({
  user_id: null,
  refreshing: false,

  _filterReords: debounce(function(user_id) {
    this._refreshRecords(user_id);
  }, 250).observes("listFilter"),

  // @computed("user_id")
  refreshRecords: function(user_id) {
    this._refreshRecords(user_id);
  },

  _refreshRecords: function(user_id) {
    this.set("refreshing", true);
    this.set("user_id", user_id);
    UserIntegral.find(user_id, { })
      .then(result => {
        this.set("model", result);
      })
      .finally(() => {
        this.set("refreshing", false);
      });
  },

  actions: { 
    
  }
});

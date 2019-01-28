import UserIntegral from '../models/user-integral';
import debounce from "discourse/lib/debounce";
import { default as computed } from "ember-addons/ember-computed-decorators";
import { i18n } from "discourse/lib/computed";
import { observes } from "ember-addons/ember-computed-decorators";

export default Ember.Controller.extend({
  user_id: null,
  refreshing: false,
  loading: false,
  currentPage: 1,
  isHasUsers: true,

  // @computed("user_id")
  refreshRecords: function(user_id) {
    this._refreshRecords(user_id);
  },

  _refreshRecords: function(user_id) {
    this.set("refreshing", true);
    this.set("user_id", user_id);
    UserIntegral.findAll(user_id, { })
      .then(result => {
        this.set("model", result);
      })
      .finally(() => {
        this.set("refreshing", false);
      });
  },

  actions: { 
    loadMore() {
      if (this.get("loading")) {
        return;
      }

      if (this.get("isHasUsers")) {
        this.set("loading", true);
        this.set("currentPage", (this.get('currentPage') + 1));

        UserIntegral.findAll(this.get("user_id"), { page: this.get('currentPage') })
        .then(result => {
          if (result.length > 0) {
            this.get("model").addObjects(
              result.map(r => UserIntegral.create(r))
            );
          } else {
            this.set("isHasUsers", false);
            this.set("currentPage", (this.get('currentPage') - 1));
          }
          this.set("loading", false);
        });
      }
    }
  }
});

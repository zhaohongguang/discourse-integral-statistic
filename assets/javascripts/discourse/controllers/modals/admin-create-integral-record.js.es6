import ModalFunctionality from "discourse/mixins/modal-functionality";
import { default as computed } from "ember-addons/ember-computed-decorators";
import { popupAjaxError } from "discourse/lib/ajax-error";
import Rule from "../../models/rule";


export default Ember.Controller.extend(ModalFunctionality, {
  themesController: Ember.inject.controller("adminCustomizeThemes"),
  types: function() {
    var list = [];
    let rules_list_promise = Rule.find();
    console.log(rules_list_promise);
    rules_list_promise.then(function(rules_list) {
      console.log(rules_list);
      rules_list.forEach(rule => {
        list.push({value: rule.id, name: I18n.t(`admin.rule_type.${rule.rule_type}`)})
      });
    });
    // rules_list.forEach(rule => {
    //   list.push({value: rule.id, name: I18n(concat('admin.rule_type', rule.rule_type))})
    // });
    return list;
  }.property(),

  actions: {
    createTheme() {
      if (this.get("nameTooShort")) {
        this.set("triggerError", true);
        return;
      }

      this.set("saving", true);
      const theme = this.store.createRecord("theme");
      theme
        .save({ name: this.get("name"), component: this.get("component") })
        .then(() => {
          this.get("themesController").send("addTheme", theme);
          this.send("closeModal");
        })
        .catch(popupAjaxError)
        .finally(() => this.set("saving", false));
    }
  }
});

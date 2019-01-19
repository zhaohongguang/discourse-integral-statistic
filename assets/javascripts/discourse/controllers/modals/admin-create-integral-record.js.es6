import ModalFunctionality from "discourse/mixins/modal-functionality";
import { default as computed } from "ember-addons/ember-computed-decorators";
import { popupAjaxError } from "discourse/lib/ajax-error";
import Rule from "../../models/rule";
import { ajax } from "discourse/lib/ajax";

export default Ember.Controller.extend(ModalFunctionality, {
  integralRecordController: Ember.inject.controller("adminUserIntegralsList"),

  onShow() {
    this.set("name", null);
    this.set("model", this.get("types"));
  },

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
    return list;
  }.property(),

  actions: {
    createRecord() {
      var note = this.get("name");
      // var name = $('.ember-text-field').val();
      var rule_id = $('.select-kit-header').attr('data-value');
      var url = window.location.pathname;
      var urlArr = url.split("/");
      var userId = urlArr[3];
      ajax("/admin/user/" + userId +"/integral-record.json", {
        type: "POST",
        data: {
          note: note,
          rule_id: rule_id,
        }
      }).then(() => { 
        this.send("closeModal");
        this.get("integralRecordController").refreshRecords(userId);
      });

      // if (this.get("nameTooShort")) {
      //   this.set("triggerError", true);
      //   return;
      // }

      // this.set("saving", true);
      // const theme = this.store.createRecord("theme");
      // theme
      //   .save({ name: this.get("name"), component: this.get("component") })
      //   .then(() => {
      //     this.get("themesController").send("addTheme", theme);
      //     this.send("closeModal");
      //   })
      //   .catch(popupAjaxError)
      //   .finally(() => this.set("saving", false));
    }
  }
});

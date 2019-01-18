import { ajax } from 'discourse/lib/ajax';

const Rule = Discourse.Model.extend({
  
});

Rule.reopenClass({
  find() {
    return ajax("/admin/rules.json" ).then(function(rules) {
      return rules.map(r => Rule.create(r));
    });
  }
});

export default Rule;
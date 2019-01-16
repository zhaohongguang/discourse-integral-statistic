import { acceptance } from "helpers/qunit-helpers";

acceptance("DiscourseIntegralStatistic", { loggedIn: true });

test("DiscourseIntegralStatistic works", async assert => {
  await visit("/admin/plugins/discourse-integral-statistic");

  assert.ok(false, "it shows the DiscourseIntegralStatistic button");
});

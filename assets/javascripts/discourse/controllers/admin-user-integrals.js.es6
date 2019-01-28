import AdminUsersListShowController from 'admin/controllers/admin-users-list-show';
import AdminUser from "admin/models/admin-user";

export default AdminUsersListShowController.extend({
  loading: false,
  currentPage: 1,
  isHasUsers: true,

  actions: {
    loadMore() {
      if (this.get("loading")) {
        return;
      }

      if (this.get("isHasUsers")) {
        this.set("loading", true);
        this.set("currentPage", (this.get('currentPage') + 1));
        AdminUser.findAll(null, { show_emails: true, page: this.get('currentPage') })
        .then(result => {
          if (result.length > 0) {
            this.get("model").addObjects(
              result.map(u => AdminUser.create(u))
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

class Admin::Report::PublishesController < Admin::AdminController
  include AdminPolicies

  def index
    sql = Publish.active
                 .joins('INNER JOIN stores AS s ON s.id = publishes.store_id AND (s.id = stores.id OR s.store_id = stores.id)')
                 .select('count(*)')
                 .to_sql

    @apps = App.joins(:store).select('apps.id, apps.name, apps.store_id, apps.created_at')
                             .select('stores.name as store_name')
                             .select("( #{ sql } ) as count_all")
                             .where("( #{ sql } ) > 0")
                             .order('apps.created_at DESC')

    @apps = @apps.where('stores.franchise_id = ?', current_franchise.id) if current_franchise
  end
end

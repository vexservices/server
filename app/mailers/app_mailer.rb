class AppMailer < ActionMailer::Base
  default from: 'developer@vexservices.com'

  def invalid_app(app)
    store = app.store
    from  = store.franchise_email  || 'developer@vexservices.com'

    @app = app
    @host = store.franchise_domain || 'vexapps.com'
    @franchise = store.franchise_name || 'Virtual Exchange'

    mail(to: store.emails, subject: default_i18n_subject, from: from) if store.emails
  end
end

module FranchisesHelper
  def franchise_logo
    current_franchise.present? ? current_franchise.logo.url(:normal) : 'logo_full.png'
  end

  def franchise_small_logo
    current_franchise.present? ? current_franchise.logo.url(:small) : 'logo.png'
  end

  def franchise_name
    current_franchise.present? ? current_franchise.name : 'Virtual Exchange'
  end

  def franchise_domain
    current_franchise.present? ? current_franchise.domain : 'www.vexapps.com'
  end

  def sellers_by_franchise(franchise = nil)
    franchise.present? ? franchise.sellers : Seller.super
  end

  def plans_by_franchise(franchise = nil)
    franchise.present? ? franchise.plans : Plan.super
  end

  def link_to_franchise_register_path
    label =
      if current_franchise.has_trial_period?
        t('buttons.sign_up_free', days: current_franchise.trial_period)
      else
        t('buttons.sign_up')
      end

    link_to label, new_user_registration_path, class: 'btn btn-lg btn-theme'
  end

  def paypal_message
    info_message(
      t('messages.paypal_html',
        link: link_to('https://registration.paypal.com/pro20PayPalCreateAccount.do', 'https://registration.paypal.com/pro20PayPalCreateAccount.do', target: '_blank'),
        manager_link: link_to('https://manager.paypal.com', 'https://manager.paypal.com', target: '_blank')
      )
    )
  end
end

module SellersHelper
  def seller_link
    url = current_franchise ? seller_root_url(domain: current_franchise.domain) : seller_root_url

    link_with_icon t('buttons.seller_link'), url,
      class: 'btn btn-info btn-labeled', icon: 'external-link'
  end

  def mail_to_seller(seller)
    mail_to seller.email, body: seller_url(seller.number), class: 'btn btn-sm btn-default' do
      content_tag :span, nil, class: 'btn-label icon fa fa-envelope'
    end
  end
end

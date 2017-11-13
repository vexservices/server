class InvoicePdf < Prawn::Document

  def initialize(invoice, view)
    super(top_margin: 45)

    @invoice = invoice
    @store   = invoice.store
    @view    = view

    header
    move_down(40)
    invoice_detail
    move_down(40)
    summary
    move_down(80)
    from
    to
  end

  def header
    fill_color "2D2D2D"
    text @view.franchise_name, size: 24, style: :bold
    fill_color "C6C4C4"
    text @view.franchise_domain, size: 18, style: :italic
  end

  def invoice_detail
    fill_color "005EC3"
    text @view.hn(Invoice), size: 32, style: :bold

    fill_color "2D2D2D"

    move_down(10)
    text "#{ @view.ta(Invoice, 'number') }: ##{ @invoice.number } ", size: 18
    move_down(2)

    if @invoice.paid_at
      text "#{ @view.ta(Invoice, 'paid_at') }: #{ @view.l(@invoice.paid_at, format: :date) }", size: 18
    end
  end

  def summary
    text "#{ @view.t('pdf.invoice.summary') }:", size: 20, style: :bold

    move_down(25)

    table summary_itens, cell_style: { size: 12 }, width: 550 do
      cells.padding = 8

      rows(0).font_style = :bold
      rows(0).align = :center
      rows(0).text_color = 'FFFFFF'

      columns(0..4).align = :center
      columns(0..4).border_color = '005EC3'

      self.row_colors = ["005EC3", "FFFFFF"]
    end

    move_down(25)

    text "Total: #{ @view.number_to_currency(@invoice.value_by_locale) }", size: 16, style: :bold, align: :right

    if I18n.locale == :'pt-BR'
      move_down(15)

      text I18n.t('pdf.invoice.value.info', value: @view.number_to_currency(@invoice.value, unit: '$')), size: 12, style: :bold
    end
  end

  def summary_itens
    [
      [@view.ta(Invoice, 'created_at'), @view.hn(Plan), @view.ta(Invoice, 'number'), @view.ta(Invoice, 'value')],
      [@view.l(@invoice.created_at, format: :date), @invoice.plan_name, @invoice.number, @view.number_to_currency(@invoice.value_by_locale)]
    ]
  end

  def from
    bounding_box([0, cursor], :width => 275) do
      fill_color "2D2D2D"
      text @view.t('pdf.invoice.from'), size: 18, style: :bold
      move_down(10)
      text "Virtual Exchange App", size: 16, style: :bold
      text "2665 N Atlantic Ave", size: 16
      text "Unit 130, Daytona Beach - 32118", size: 16
      text "United States", size: 16
    end
  end

  def to
    bounding_box([300, cursor + 105], :width => 275) do
      fill_color "2D2D2D"
      text @view.t('pdf.invoice.to'), size: 18, style: :bold
      move_down(10)
      text @store.name, size: 16, style: :bold
      text @store.address_street, size: 16
      text "#{ @store.address_city } - #{ @store.address_zip }", size: 16
      text @store.address_state, size: 16
      text Country[@store.address_country].name, size: 16
    end
  end
end

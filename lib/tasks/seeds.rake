namespace :seed do
  task :departments => :environment do
    hash = [
      { name: 'BOOKS_AND_REFERENCE', title_en: 'Books and Reference', title_es: 'Libros y Referencia', title_pt_br: 'Livros e Referência' },
      { name: 'BUSINESS', title_en: 'Business', title_es: 'Negocios', title_pt_br: 'Negócio' },
      { name: 'CATALOGS', title_en: 'Catalogs', title_es: 'Catálogos', title_pt_br: 'Catálogos' },
      { name: 'COMICS', title_en: 'Comics', title_es: 'Historietas', title_pt_br: 'História em Quadrinhos' },
      { name: 'COMMUNICATION', title_en: 'Communication', title_es: 'Comunicación', title_pt_br: 'Comunicação' },
      { name: 'EDUCATION', title_en: 'Education', title_es: 'Educación', title_pt_br: 'Educação' },
      { name: 'ENTERTAINMENT', title_en: 'Entertainment', title_es: 'Entretenimiento', title_pt_br: 'Entreterimento' },
      { name: 'FINANCE', title_en: 'Finance', title_es: 'Finanzas', title_pt_br: 'Finanças' },
      { name: 'FOOD & DRINK', title_en: 'Food & Drink', title_es: 'Comer y Beber', title_pt_br: 'Comidas e Bebidas' },
      { name: 'GAMES', title_en: 'Games', title_es: 'Juegos', title_pt_br: 'Jogos' },
      { name: 'HEALTH_AND_FITNESS', title_en: 'Health and Fitness', title_es: 'Salud y Fitness', title_pt_br: 'Saúde & Bem-Estar' },
      { name: 'LIBRARIES_AND_DEMO', title_en: 'Libraries and Demo', title_es: 'Bibliotecas y Demostración', title_pt_br: 'Bibliotecas e Demonstração' },
      { name: 'LIFESTYLE', title_en: 'Lifestyle', title_es: 'Estilo de Vida', title_pt_br: 'Estilo de Vida' },
      { name: 'MEDIA_AND_VIDEO', title_en: 'Media and Video', title_es: 'Medios y Video', title_pt_br: 'Mídia e Vídeo' },
      { name: 'MEDICAL', title_en: 'Medical', title_es: 'Médico', title_pt_br: 'Médico' },
      { name: 'MUSIC_AND_AUDIO', title_en: 'Music and Audio', title_es: 'Música y audio', title_pt_br: 'Áudio e Música' },
      { name: 'NAVIGATION', title_en: 'Navegation', title_es: 'Navegación', title_pt_br: 'Navegação' },
      { name: 'NEWS_AND_MAGAZINES', title_en: 'News and Magazines', title_es: 'Noticias y revistas', title_pt_br: 'Notícias e Revistas' },
      { name: 'PERSONALIZATION', title_en: 'Personalization', title_es: 'Personalización', title_pt_br: 'Personalização' },
      { name: 'PHOTOGRAPHY & VIDEO', title_en: 'Photography & Video', title_es: 'Fotografía y Video', title_pt_br: 'Fotografia e Vídeo' },
      { name: 'PRODUCTIVITY', title_en: 'Productivity', title_es: 'Productividad', title_pt_br: 'Produtividade' },
      { name: 'REFERENCE', title_en: 'Reference', title_es: 'Referencia', title_pt_br: 'Referência' },
      { name: 'SHOPPING', title_en: 'Shopping', title_es: 'Compras', title_pt_br: 'Shopping' },
      { name: 'SOCIAL NETWORKING', title_en: 'Social Networking', title_es: 'Redes Sociales', title_pt_br: 'Redes Sociais' },
      { name: 'SPORTS', title_en: 'Sports', title_es: 'Deportes', title_pt_br: 'Esportes' },
      { name: 'TOOLS', title_en: 'Tools', title_es: 'Instrumentos', title_pt_br: 'Ferramentas' },
      { name: 'TRANSPORTATION', title_en: 'Transportation', title_es: 'Transporte', title_pt_br: 'Transporte' },
      { name: 'TRAVEL_AND_LOCAL', title_en: 'Travel and Local', title_es: 'Viajes y Local', title_pt_br: 'Viagens e Local' },
      { name: 'UTILITIES', title_en: 'Utilities', title_es: 'Utilidades', title_pt_br: 'Utilidades' },
      { name: 'WEATHER', title_en: 'Weather', title_es: 'Tiempo', title_pt_br: 'Tempo' }
    ]

    hash.each { |h| Department.create(h) }
  end

  task :products => :environment do
    hash = [
      { name: 'Product One',   description: 'Donec vehicula finibus neque vel.', price: 59.99, regular_price: 99.99 },
      { name: 'Product Two',   description: 'Fusce at arcu ut erat.', price: 19.99, regular_price: 39.99 },
      { name: 'Product Three', description: 'Vestibulum ipsum mauris, fringilla vel.', price: 199.99, regular_price: 399.99 }
    ]

    hash.each do |h|
      product = Product.create!(h)

      product.publishes.create!(
        price: product.price,
        regular_price: product.regular_price,
        published_until: DateTime.current + 100.years
      )
    end
  end
end

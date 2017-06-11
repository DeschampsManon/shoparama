class CreateProductService

  def call
    params = search_products(params[:search])
    product = Product.find_or_initialize_by(reference: product.reference)
  end

  def search_products(params)
    request ||= Vacuum.new('FR')

    request.configure(
        aws_access_key_id: 'AKIAIESVQF7JDUQBSHZA',
        aws_secret_access_key: '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',
        associate_tag:'150dd-21'
    )

    response = request.item_search(
        query: {
            'SearchIndex'   => 'All',
            'Keywords'      =>  params[:search],
            'ResponseGroup' => 'ItemAttributes,Images',
        }
    )

    @products = []

    hashed_products = response.to_h

    hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
      product = OpenStruct.new
      product.reference = item['ItemAttributes']['EAN']

      product.name = item['ItemAttributes']['Title']
      product.price = item['ItemAttributes']['ListPrice']['FormattedPrice'].split('EUR ')[1] if item['ItemAttributes']['ListPrice']
      product.url = item['DetailPageURL']

      product.category = item['ItemAttributes']['ProductGroup']

      product.image_url = item['LargeImage']['URL'] if item['LargeImage']

      product.dimensions = item['ItemAttributes']['ItemDimensions']

      @products << product
    end
  end

end
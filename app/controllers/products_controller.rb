class ProductsController < ApplicationController

  def index
    if params[:search]
      keywords = params[:search].strip.split(/\s+/)
      keywords.each_with_index do |keyword, index|
        if index != 0
          @products = @products.or(ProductSeller.where('lower(name) LIKE ?', "%#{keyword.downcase}%"))
        else
          @products = ProductSeller.where('lower(name) LIKE ?', "%#{keyword.downcase}%")
        end
      end
    else
      @products = Products.all
      @categories = Category.all
    end
  end

  def create
    if params[:search].present?
      # CONNECT TO AMAZON API
      request ||= Vacuum.new('FR')
      request.configure(
        aws_access_key_id: ENV['aws_access_key_id'],
        aws_secret_access_key: ENV['aws_secret_access_key'],
        associate_tag: ENV['associate_tag']
      )

      # SEARCH AMAZON PRODUCTS WITH KEYWORD
      amazon_response = request.item_search(
        query: {
          'SearchIndex'   => 'All',
          'Keywords'      =>  params[:search],
          'ResponseGroup' => 'ItemAttributes,Images',
        }
      )

      hashed_products = amazon_response.to_h

      # INITIALIZE ARRAY
      @amazon_products = []

      hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
        # PARSE JSON RESPONSE
        product = OpenStruct.new
        product.reference = item['ItemAttributes']['EAN']
        product.name = item['ItemAttributes']['Title']
        product.price = item['ItemAttributes']['ListPrice']['FormattedPrice'].split('EUR ')[1] if item['ItemAttributes']['ListPrice']
        product.url = item['DetailPageURL']
        product.category = item['ItemAttributes']['ProductGroup']
        product.image_url = item['LargeImage']['URL'] if item['LargeImage']
        product.dimensions = item['ItemAttributes']['ItemDimensions']

        # CONNECT TO EBAY API -> (initializers/rebay.rb)
        finder = Rebay::Finding.new

        # SEARCH EBAY PRODUCTS WITH KEYWORD
        ebay_response = finder.get_search_keywords_recommendation({:keywords => params[:search]})

        #binding.pry
        # CREATE CATEGORY IF NOT EXIST
        @category = Category.find_or_initialize_by(name: product.category)

        #GET CATEGORY ID
        if @category.save
          @category_id = @category.id
        else
          @category_id = Category.where(name: product.category).first.id
        end

        # CREATE PRODUCT IF NOT EXIST
        @product = Product.find_or_initialize_by(reference: product.reference)

        #SET PRODUCT CATEGORY ID
        if @product.save
          @product.category_ids = @category.id
          @product_seller = ProductSeller.new
          @product_seller.website = "Amazon"
          @product_seller.url = product.url
          @product_seller.price = product.price
          @product_seller.name = product.name
          @product_seller.thumbnail = product.image_url
          @product_seller.product_id = @product.id
          @product_seller.save
        end

      end
      redirect_to action: 'index', search: params[:search]
    end
  end

end
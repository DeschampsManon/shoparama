class ProductsController < ApplicationController

  def index
    if params[:search]
      product_ids = []
      keywords = params[:search].strip.split(/\s+/)
      keywords.each_with_index do |keyword, index|
        if index != 0
          @product_sellers = @product_sellers.or(ProductSeller.where('lower(name) LIKE ?', "%#{keyword.downcase}%"))
        else
          @product_sellers = ProductSeller.where('lower(name) LIKE ?', "%#{keyword.downcase}%")
        end
      end
      @product_sellers.each do |product_seller|
        product_ids << product_seller.id
      end
      @categories = Category.joins(:product_sellers).where("product_sellers.id IN (?)", product_ids)
    else
      @product_sellers = ProductSeller.all
      @categories = Category.all
      if params[:category]
        category_ids = params[:category]
        @product_sellers = @product_sellers.joins(:categories).where("categories.id IN (?)", category_ids)
        respond_to do |format|
          format.js
        end
      end
    end
    @product_sellers = @product_sellers.paginate(:page => params[:page], :per_page => 15)
  end

  def create
    if params[:search].present?
        @index_search = 0
        all_products = create_from_amazon(params) + create_from_ebay(params)
        all_products.each do |api_product|
          create_final_product(api_product)
        end
      end
      # LOAD PRODUCT INDEX PAGE WITH PARAMS SEARCH
      redirect_to action: 'index', search: params[:search]
    end
  end

  def create_final_product(api_product)
    # CREATE CATEGORY IF NOT EXIST
    category = Category.find_or_create_by!(name: api_product[:category])

    # CREATE PRODUCT IF NOT EXIST
    product = Product.find_or_initialize_by(reference: api_product[:reference])
    product.save!

    # CREATE PRODUCT SELLER
    product_seller = ProductSeller.new
    product_seller.category_ids << category.id
    product_seller.website = api_product[:source]
    product_seller.url = api_product[:url]
    product_seller.price = api_product[:price]
    product_seller.name = api_product[:name]
    product_seller.thumbnail = api_product[:image_url]
    product_seller.product_id = product.id
    product_seller.save!
  end

  def create_from_ebay(params)
    # CONNECT TO EBAY API -> (initializers/rebay.rb)
    finder = Rebay::Finding.new

    # SEARCH EBAY PRODUCTS WITH KEYWORD
    keywords = (params[:search].gsub(',','').split( /  */ ).join(',')) # Split anf join to find items with one or more keyword in params.
    ebay_response = finder.find_items_in_ebay_stores({:keywords => keywords})

    product = []
    # PARSE JSON RESPONSE
    ebay_response.each do |item|
      #p item.to_json
      #p item.class.to_s
      hash_local = {}
      hash_local[:reference] = item['itemId']
      hash_local[:name] = item['title']
      hash_local[:price] = item['currentPrice']['__value__'] if item['currentPrice']
      hash_local[:url] = item['viewItemURL']
      hash_local[:category] = item['primaryCategory']['categoryName']
      hash_local[:image_url] = item['galleryURL']
      hash_local[:source] = "ebay"
      product.push hash_local
      @index_search += 1
    end
      return product
  end

  def create_from_amazon(params)
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

    hashed_amazon_products = amazon_response.to_h
    product = []
    hashed_amazon_products['ItemSearchResponse']['Items']['Item'].each_with_index do |item,index|
      hash_local = {}
      # PARSE JSON RESPONSE
      hash_local[:reference] = item['ItemAttributes']['EAN']
      hash_local[:name] = item['ItemAttributes']['Title']
      hash_local[:price] = item['ItemAttributes']['ListPrice']['FormattedPrice'].split('EUR ')[1] if item['ItemAttributes']['ListPrice']
      hash_local[:url] = item['DetailPageURL']
      hash_local[:category] = item['ItemAttributes']['ProductGroup']
      hash_local[:image_url] = item['LargeImage']['URL'] if item['LargeImage']
      hash_local[:dimensions] = item['ItemAttributes']['ItemDimensions']
      hash_local[:source] = "amazon"
      product.push hash_local
      @index_search += 1
    end
      return product

end
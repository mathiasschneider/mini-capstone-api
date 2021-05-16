class ProductsController < ApplicationController
  def index
    product = Product.where("name iLIKE ?", "%#{params[:search]}%")
    render json: product
  end

  def index
    products = Product.all

    if params[:search]
      products = products.where("name iLIKE ?", "%#{params[:search]}%")
    end

    if params[:sort] == "price"
      products = products.order(price: :asc)
    else
      products = products.order(id: :asc)
    end

    render json: products
  end
  
  def create
    product = Product.new(
      name: params[:name],
      price: params[:price],
      image_url: params[:image_url],
      description: params[:description]
    )
    if product.save == true
      render json: product
    else
      render json: product.errors.full_messages
    end
  end

  def show
    product = Product.find(params[:id])
    render json: product
  end

  def update
    product = Product.find(params[:id])
    product.name = params[:name] || product.name
    product.price = params[:price] || product.price
    product.image_url = params[:image_url] || product.image_url
    product.description = params[:description] || product.description
    if product.save == true
      render json: product
    else
      render json: product.errors.full_messages
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: {message: "#{product.name} was successfully destroyed."}
  end

#   #query and segment both use this:
#   def single_param
#     id_number = params[:single_product]
#     product = Product.find_by(id: id_number)
#     render json: {message: product}
#   end
end

class SearchesController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  def index
  end
  def show
    @keys = Key.all
    @keys.each do |key|
      if key.key != @activation

          redirect_to '/admin'


      end
    end
    @labelrent = Typesofrent.find(params[:id])
    @searches = Search.where(public: true)
    @searches1 = @searches.where(typesofrent_id: params[:id])
    @searches2 =  @searches1.order "busy ASC"
    @nophoto = Nophoto.all

    @nophoto.each do |nophoto|
      @no = nophoto.image
    end
  end
  def more
    @labelrent = Typesofrent.find(params[:id])
    @searches = Search.where(public: true)
    @searches1 = @searches.where(typesofrent_id: params[:id])
    @keys = Key.all
    @keys.each do |key|
      if key.key != @activation

          redirect_to '/admin'


      end
    end
    @nophoto = Nophoto.all

    @nophoto.each do |nophoto|
      @no = nophoto.image
    end
    @search = Search.find(params[:id])
    @regions = Region.where(id: @search.region_id)
    @regions.each do |region|
      @region = region
    end
    @brands = Brand.where(id: @search.brand_id)
    @brands.each do |brand|
      @brand = brand
    end
    @models = Model.where(id: @search.model_id)
    @models.each do |model|
      @model = model
    end
  end
  def new
    @regions = Region.all
    @typesofrents = Typesofrent.all
    @brands = Brand.all
    @models = Model.all
  end
  def create
    @search = Search.new(search_params)
    @search.username_id = current_user.id
    if @search.save
      redirect_to personals_path
    else
      render action: 'new'
    end
  end
  def edit
    @regions = Region.all
    @typesofrents = Typesofrent.all
    @brands = Brand.all
    @models = Model.all

    @search = Search.find(params[:id])
    if @search.username_id != current_user.id
      redirect_to personals_path
    end
  end
  def update
  @search = Search.find(params[:id])
  if @search.update(search_params)
    redirect_to personals_path
  else
    render action: 'edit'
  end
  end



private

  def search_params
    params.require(:search).permit(:title_ru, :title_tm, :title_en, :text_ru, :text_tm, :text_en, :region_id, :year, :typesofrent_id, :phone, :price, :email, :public, :cashless, :brand_id, :model_id, :name, :username, :username_id, :busy)
  end
end

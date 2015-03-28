module ApplicationHelper
  def embedded_svg filename, options={}
   embedded_svg_from_abs(Rails.root.join('app', 'assets', 'images', 'svg', filename), options)
  end

  def embedded_svg_from_abs filename, options = {}
   file = File.read(filename)
   doc = Nokogiri::HTML::DocumentFragment.parse file
   svg = doc.at_css 'svg'
   if options[:class].present?
     svg['class'] = options[:class]
   end
   doc.to_html.html_safe
  end

  def embedded_svg_from_root_directory filename, options = {}
   embedded_svg_from_abs(Rails.root.join( filename), options)
  end

  def embedded_svg_from_public filename, options ={}
    embedded_svg_from_root_directory("public#{filename}", options)
  end

  def self.embedded_svg_js filename, options={}
   file = File.read(Rails.root.join('app', 'assets', 'images', 'svg', filename))
   doc = Nokogiri::HTML::DocumentFragment.parse file
   svg = doc.at_css 'svg'
   if options[:class].present?
     svg['class'] = options[:class]
   end
   doc.to_html.html_safe
  end


  def products(count = nil)
    if count.blank?
      products = Product.order(created_at: :asc)
    else
      products = Product.order(created_at: :asc).limit(count)
    end
  end
  def restorans
     restoran = Restaurant.order(position: :asc)
  end

  def business_lunch
    @products_for_monday ||= Product.where(d_monday: true).order(created_at: :asc).limit(2)
    @products_for_tuesday ||= Product.where(d_tuesday: true).order(created_at: :asc).limit(2)
    @products_for_wednesday ||= Product.where(d_wednesday: true).order(created_at: :asc).limit(2)
    @products_for_thursday ||= Product.where(d_thursday: true).order(created_at: :asc).limit(2)
    @products_for_friday ||= Product.where(d_friday: true).order(created_at: :asc).limit(2)

    # @days_with_business_lunch ||= Product.where()
  end
end
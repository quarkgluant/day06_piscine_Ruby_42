class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    current_user.admin if current_user
  end

  def get_random_animal
    # url = 'https://www.randomlists.com/random-animals'
    # doc = Nokogiri::HTML(open(url))
    # # link = page.xpath("//div[class='Rand-stage']/li/a[starts-with(@href, '/wiki/')]").first
    # doc.css('li').first.children.text
    # le lien ne marche plus, après test, les noms ne sont plus dans l'objet doc
    # donc petite méthode pour tester
    %w(chat chien mouton vache cobra lion guépard hamster).sample
  end
end

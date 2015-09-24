module Helpers
  def current_user
    @current ||= User.first(id: session[:user_id])
  end

  def assign_tags(link, tags)
    params[:tag].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
  end
end

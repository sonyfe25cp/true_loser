class HeaderCell < Cell::Rails
  def show(args = {})
    @current_resource = args[:current_resource]
    scope = @current_resource ? @current_resource.class.name.demodulize.underscore : :user
    render view: scope
  end
end

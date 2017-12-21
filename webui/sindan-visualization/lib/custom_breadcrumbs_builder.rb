class CustomBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.render "layouts/breadcrumbs", elements: @elements
  end
end

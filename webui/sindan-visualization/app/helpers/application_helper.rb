module ApplicationHelper
  def full_title(page_title = nil)
    base_title = t('common.site_title')

    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def nl2br(str)
    str.gsub(/\r\n|\r|\n/, "<br />")
  end

  def hbr(str)
    str = html_escape(str)
    str.gsub(/\r\n|\r|\n/, "<br />")
  end

  def datetime_view(datetime)
    return nil if datetime.blank?
    datetime.strftime(t('time.formats.default'))
  end

  def date_view(date)
    return nil if date.blank?
    date.strftime(t('date.formats.default'))
  end

  # CSS Class
  def current_class(target_path)
    if current_page?(target_path)
      'active'
    end
  end

  # Public: Pick the correct arguments for form_for when shallow routes are used.
  #
  # parent - The Resource that has_* child
  # child - The Resource that belongs_to parent.
  def shallow_args(parent, child)
    params[:action] == 'new' ? [parent, child] : child
  end

  def shallow_deep_args(parent, child, grandchild)
    params[:action] == 'new' ? [parent, child, grandchild] : grandchild
  end
end

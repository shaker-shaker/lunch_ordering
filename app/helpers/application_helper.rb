module ApplicationHelper
  # handle devise flash types
  def bootstrap_class_for(flash_type)
    case flash_type
    when "notice"
      "info"
    when "alert"
      "danger"
    else
      flash_type.to_s
    end
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = t("layout.header.title")
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end

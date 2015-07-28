module Comfy
  module BlogHelper

    # comfy_blog_friendly_date(2015, 11)
    # => "November 2015"
    def comfy_blog_friendly_date(year, month)
      month_name = I18n.t("date.month_names")[month.to_i]
      [month_name, year].compact.join(" ")
    end

  end
end

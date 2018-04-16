module XeroGateway
  class BrandingTheme
    include Dates

    # All accessible fields
    attr_accessor :branding_theme_id, :name, :sort_order, :created_at

    def initialize(params = {})
      params.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def self.from_xml(branding_theme_element)
      branding_theme = new
      branding_theme_element.children.each do |element|
        case element.name
          when 'BrandingThemeID' then branding_theme.branding_theme_id = element.text
          when 'Name'            then branding_theme.name = element.text
          when 'SortOrder'       then branding_theme.sort_order = Integer(element.text)
          when 'CreatedDateUTC'  then branding_theme.created_at = parse_date_time_utc(element.text)
        end
      end
      branding_theme
    end

    def ==(other)
      [:branding_theme_id, :name, :sort_order, :created_at].each do |field|
        return false if send(field) != other.send(field)
      end
      return true
    end
  end
end

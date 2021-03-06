require 'orange-core'
require 'orange-more/administration'
require 'orange-more/assets'
require 'orange-more/pages'
require 'orange-more/sitemap'
require 'orange-more/slices'
require 'orange-more/disqus'
require 'orange-more/analytics'
require 'orange-more/cloud'
require 'orange-more/debugger'
require 'rack/builder'
require 'rack/abstract_format'
require 'rack-datamapper-session'
require 'openid_dm_store'
require 'omniauth'
require 'kramdown'
require 'orange-sparkles/plugin'

class Orange::SparklesApp < Orange::Application
  def stack_init
    @core.template_chooser do |packet|
      if [:admin, :orange].include?(packet['route.context'])
        packet.add_css('sparkles-admin.css', :position => 0, :module => '_sparkles_')
        packet.add_css('colorbox.css', :module => '_sparkles_')
        packet.add_css('smoothness/jquery-ui-1.7.2.custom.css', :module => '_sparkles_')
        packet.add_js('markitup/sets/markdown/set.js', :module => '_sparkles_')
        packet.add_js('markitup/jquery.markitup.pack.js', :module => '_sparkles_')
        packet.add_js('autoresize.jquery.min.js', :module => '_sparkles_')
        packet.add_js('jquery-ui-1.7.2.custom.min.js', :module => '_sparkles_')
        %w(form colorbox tools.min tablesorter tablesorter.pager).each do |js|
          packet.add_js("jquery.#{js}.js", :module => '_sparkles_')
        end
        packet.add_js('admin.js', :module => '_sparkles_')
        orange.fire(:view_admin, packet)
        'sparkles-admin.haml'
      elsif(packet['route.path'] == '/')
        ['reset', 'text'].each{|c| packet.add_css("#{c}.css", :module => '_sparkles_')}
        ['main'].each{|c| packet.add_css("#{c}.css", :module => orange[:sparkles].theme)} if orange[:sparkles].default_style?
        'home.haml'
      else
        ['reset', 'text'].each{|c| packet.add_css("#{c}.css", :module => '_sparkles_')}
        ['main'].each{|c| packet.add_css("#{c}.css", :module => orange[:sparkles].theme)} if orange[:sparkles].default_style?
        'subpage.haml'
      end
    end # end do
  end
  
  stack do
    use Rack::CommonLogger
    use Rack::MethodOverride
    use Rack::Session::DataMapper
    use_exceptions
    
    prerouting

    routing :exposed_actions => {:live => :show, :preview => :show, :admin => :all, :orange => :all}
    
    postrouting
    orange.add_pulp(SparkleHelpers)
    run Orange::SparklesApp.new(orange)
  end
  
end

class Orange::AssetResource < Orange::ModelResource
  viewable :markitup_insert, :create_markitup, :list_markitup
end

class OrangeAsset
  def to_s
    <<-DOC
    <textarea>
    {"id": #{self.id}, "name": "#{self.name}", "caption": "#{self.caption}", "html": "#{self.to_asset_tag}"}
    </textarea>
    DOC
  end
end

class OrangePage
  admin do
    fulltext :sidebar
  end
end

class OrangePageVersion
  fulltext :sidebar
end


module SparkleHelpers
  def markdown(string)
    # Preparse for radius
    # string = orange[:radius].parse_text(self, string)
    Kramdown::Document.new(string).to_html
  end
  def lorem(chars = 300)
    chars = chars.to_i
    ("Lorem ipsum dolor sit amet, consectetur adipiscing elit. In tincidunt enim eget ante semper  interdum. Proin quis erat nec tellus faucibus volutpat. Aenean ornare augue eu tellus fermentum vel blandit ipsum bibendum. Pellentesque a nisi justo, non tristique metus. Curabitur fermentum tincidunt neque, sit amet posuere dui tempor at. Suspendisse imperdiet lobortis tempus. Nulla ac sem ut lorem laoreet porttitor at vestibulum dui.

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. In tincidunt enim eget ante semper interdum. Proin quis erat nec tellus faucibus volutpat. Aenean ornare augue eu tellus fermentum vel blandit ipsum bibendum."*6)[0..chars]
  end
  def button(text, link, opts = {})
    opts.with_defaults!({:css_class => "grey-button", :method => 'POST', :confirm => false})
    if opts[:confirm]
      "<form method='POST' class='mini-form' action='#{link}'><input name='_method' type='hidden' value='#{opts[:method]}' /><a class='#{opts[:css_class]} button' onclick='if(confirm(\"#{opts[:confirm]}\")){ $(this).parent().submit(); }; return false;' href='#{link}'>#{text}</a></form>"
    else
      "<form method='POST' class='mini-form' action='#{link}'><input name='_method' type='hidden' value='#{opts[:method]}' /><a class='#{opts[:css_class]} button' onclick='$(this).parent().submit(); return false;' href='#{link}'>#{text}</a></form>"
    end
  end
  def delete_button(link)
    button("Delete", link, {:css_class => "delete-button", :method => "DELETE", :confirm => "Are you sure you want to delete this?"})
  end
  def move_button(dir, route)
    action = packet.route_to(:sitemap, route.id, dir)
    case dir
    when "outdent"
      disabled = true unless route.level > 1 
    when "indent"
      disabled = true unless route.previous_sibling
    when "higher"
      disabled = true unless route.previous_sibling
    when "lower"
      disabled = true unless route.next_sibling
    end
    unless disabled
      return "<form method='POST' class='move-arrow' action='#{action}'><a href='#{action}' class='move-#{dir}' onclick=''><img src='/assets/_sparkles_/images/move-#{dir}.png' /></a></form>"
    else return "<a class='move-#{dir} move-disabled'><img src='/assets/_sparkles_/images/move-#{dir}-disabled.png' /></a>"
    end
  end
end
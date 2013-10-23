require 'mharris_ext'
require 'andand'

module <%= module_name %>
  def self.load_files!
    %w().each do |f|
      load File.dirname(__FILE__) + "/<%= name %>/#{f}.rb"
    end
  end
end

<%= module_name %>.load_files!
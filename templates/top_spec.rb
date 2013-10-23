require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "<%= module_name %>" do
  it 'smoke' do
    <%= module_name %>.should be
  end
end

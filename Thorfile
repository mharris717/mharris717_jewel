require 'thor'


class Jewel < Thor
  include Thor::Actions
  argument :name
  def self.source_root
    "/code/orig"
  end

  desc "create NAME","create Jewel"
  def create
    run "cd /code/orig && jeweler #{name} --summary #{name} --description #{name} --rspec"
    write_templates
    initial_setup
  end

  no_commands do
    def module_name
      camelize(name)
    end
    def guard_port
      @guard_port ||= 5000 + rand(5000)
    end
    def write_templates
      dir = "/code/orig/#{name}"
      root = "/code/orig/mharris717_jewel"
      my_template("#{root}/templates/Gemfile", "#{dir}/Gemfile")
      my_template("#{root}/templates/Guardfile", "#{dir}/Guardfile")
      my_template("#{root}/templates/spec_helper.rb","#{dir}/spec/spec_helper.rb")
      my_template("#{root}/templates/lib_top.rb","#{dir}/lib/#{name}.rb")
      my_template("#{root}/templates/top_spec.rb","#{dir}/spec/#{name}_spec.rb")
      `mkdir #{dir}/lib/#{name}`
      `mkdir #{dir}/spec/support`
    end

    def camelize(str)
      str.split('_').map {|w| w.capitalize}.join
    end



    def ec(cmd)
      dir = "/code/orig/#{name}"
      puts cmd
      res = `cd #{dir} && #{cmd}`
      puts res
      res
    end

    def initial_setup
      dir = "/code/orig/#{name}"
      ec "bundle exec ruby ./lib/#{name}.rb"
      ec "git add ."
      ec "git commit -m 'Initial State'"
      `echo 0.0.1 > #{dir}/VERSION`
      ec "rake gemspec"
      ec "git add ."
      ec "git commit -m 'Initial State' --amend"
      ec "rake gemspec"
      ec "git add ."
      ec "git commit -m 'Initial State' --amend"

      ec "hub create"
      ec "travis init ruby --rvm 1.9.3 --script 'bundle exec rake spec'"
      ec "git add ."
      ec "git commit -m 'Initial State' --amend"

      ec "git push origin master"

      ec "bundle config local.#{name} #{dir}"
    end

    def my_template(source,target)
      `rm #{target}` if FileTest.exist?(target)
      template(source,target)
    end
  end
end

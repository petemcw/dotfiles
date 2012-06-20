#
# Install dotfiles as symlinks in standard home directory locations. This script
# allows for processing of ERB templates as well as backup and restore options.
#
# Built from a compilation of:
# - https://github.com/holman/dotfiles
# - https://github.com/nicknisi/dotfiles
require 'rake'
require 'erb'

def linkables
  linkables = Dir.glob('**/*.symlink')
  linkables.each do |linkable|
    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"
    yield linkable, file, target if block_given?
  end
end

desc "Make a backup of any files that will be replaced (if they exist)"
task :backup do
  linkables do |linkable, file, target|
    # Check if non-erb version exists
    if file =~ /.erb$/
      target = ENV["HOME"] + "/" + ".#{file.sub('.erb', '')}"
    end

    # Create backup copy of target file
    if File.exists?(target) || File.symlink?(target)
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"`
    end
  end
end

desc "Restore backed-up files"
task :restore do
  linkables do |linkable, file, target|
    if File.exists?("#{ENV['HOME']}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"`
    end
  end
end

desc "Create symlinks in system-standard positions"
task :install do
  linkables do |linkable, file, target|
    unless File.exists?(target)
      if file =~ /.erb$/
        File.open(File.join(ENV["HOME"], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
          new_file.write ERB.new(File.read(linkable)).result(binding)
        end
      else
        `ln -s "$PWD/#{linkable}" "#{target}"`
      end
    end
  end
end

desc "Remove all symlinks added during installation"
task :uninstall do
  linkables do |linkable, file, target|
    if File.symlink?(target)
      FileUtils.rm(target)
    end
  end
end

task :default => 'install'

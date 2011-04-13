#!/bin/sh
# rake bash completion script

complete_rake_command() {
    [ -f Rakefile ] || exit 0
    mkdir -p ~/.rake/tc_cache
    /usr/bin/env ruby <<EOF
    # Francis Hwang ( http://fhwang.net/ ) building on work of
    # Nicholas Seckar <nseckar@gmail.com>
    exit 0 unless /^rake(?:\s+([-\w]+))?\s*$/ =~ ENV["COMP_LINE"]
    task_prefix = \$1
    rakefile = "#{Dir.pwd}/Rakefile"
    cache_dir = "#{ENV['HOME']}/.rake/tc_cache"
    cache_file = File.join(cache_dir, rakefile.gsub(%r{/}, '_' ))
    if File.exist?(cache_file) && File.mtime(cache_file) >= File.mtime(rakefile)
        task_lines = File.read(cache_file)
    else
        task_lines = \`rake --tasks\`
        File.open(cache_file, 'wb') { |f| f.write(task_lines) }
    end
    tasks = task_lines.
        split("\\n")[1..-1].collect {|line| line.split[1]}
    tasks = tasks.
        select {|t| /^#{Regexp.escape(task_prefix)}/ =~ t} if task_prefix
    puts tasks
    exit 0
EOF
    return $?
}

# bring in rake completion.
complete -C complete_rake_command -o default rake

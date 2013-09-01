package "git" do
    action :install
end

package "make" do
    action :install
end

package "gcc" do
    action :install
end

bash "Install perl for kamesho" do
  user "kamesho"
  group "kamesho"
  environment "HOME" => "/home/kamesho"
  not_if { File.exist?("$HOME/.plenv") }
  code <<-EOC
        git clone git://github.com/tokuhirom/plenv.git $HOME/.plenv
        echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> $HOME/.bash_profile
        echo 'eval "$(plenv init -)"' >> $HOME/.bash_profile
        git clone git://github.com/tokuhirom/Perl-Build.git $HOME/.plenv/plugins/perl-build/
        $HOME/.plenv/bin/plenv install 5.18.0
        $HOME/.plenv/bin/plenv rehash
        $HOME/.plenv/bin/plenv global 5.18.0 
        $HOME/.plenv/bin/plenv install-cpanm
        $HOME/.plenv/bin/plenv rehash
        $HOME/.plenv/shims/cpanm Carton 
  EOC
  action :run
end


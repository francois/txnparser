task :test do
  $LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
  $LOAD_PATH.unshift File.expand_path("../spec", __FILE__)

  FileList["spec/**/*_spec.rb"].each{|fn| require fn.sub(/^spec\//, "").sub(/.rb$/, "")}

  require "minitest/autorun"
end

task :default => :test

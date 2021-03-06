require 'spec_helper'

describe Bibliothecary::Parsers::Shard do
  it 'has a platform name' do
    expect(Bibliothecary::Parsers::Shard::platform_name).to eq('shard')
  end

  it 'parses dependencies from shard.yml' do
    expect(Bibliothecary::Parsers::Shard.analyse_file('shard.yml', fixture_path('shard.yml'))).to eq({
      :platform=>"shard",
      :path=>"spec/fixtures/shard.yml",
      :dependencies=>[
        {:name=>"frost", :requirement=>"*", :type=>"runtime"},
        {:name=>"shards", :requirement=>"*", :type=>"runtime"},
        {:name=>"common_mark", :requirement=>"*", :type=>"runtime"},
        {:name=>"minitest", :requirement=>">= 0.2.0", :type=>"runtime"},
        {:name=>"selenium-webdriver", :requirement=>"*", :type=>"runtime"}
      ]
    })
  end

  it 'parses dependencies from shard.lock' do
    expect(Bibliothecary::Parsers::Shard.analyse_file('shard.lock', fixture_path('shard.lock'))).to eq({
      :platform=>"shard",
      :path=>"spec/fixtures/shard.lock",
      :dependencies=>[
        {:name=>"common_mark", :requirement=>"0.1.0", :type=>"runtime"},
        {:name=>"frost", :requirement=>"*", :type=>"runtime"},
        {:name=>"minitest", :requirement=>"0.3.1", :type=>"runtime"},
        {:name=>"pg", :requirement=>"0.5.0", :type=>"runtime"},
        {:name=>"pool", :requirement=>"0.2.1", :type=>"runtime"},
        {:name=>"selenium-webdriver", :requirement=>"0.1.0", :type=>"runtime"},
        {:name=>"shards", :requirement=>"0.6.0", :type=>"runtime"}
      ]
    })
  end
end

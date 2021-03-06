require 'spec_helper'

describe Bibliothecary::Parsers::Bower do
  it 'has a platform name' do
    expect(Bibliothecary::Parsers::Bower::platform_name).to eq('bower')
  end

  it 'parses dependencies from bower.json' do
    expect(Bibliothecary::Parsers::Bower.analyse_file('bower.json', fixture_path('bower.json'))).to eq({
      :platform=>"bower",
      :path=>"spec/fixtures/bower.json",
      :dependencies=>[
        {:name=>"jquery", :requirement=>">= 1.9.1", :type=>"runtime"}
      ]
    })
  end
end

require 'spec_helper'

describe Bibliothecary::Parsers::Meteor do
  it 'has a platform name' do
    expect(Bibliothecary::Parsers::Meteor::platform_name).to eq('meteor')
  end

  it 'parses dependencies from versions.json' do
    expect(Bibliothecary::Parsers::Meteor.analyse_file('versions.json', fixture_path('versions.json'))).to eq({
      :platform=>"meteor",
      :path=>"spec/fixtures/versions.json",
      :dependencies=>[
        {:name=>"accounts-base", :requirement=>"1.1.2", :type=>"runtime"},
        {:name=>"application-configuration", :requirement=>"1.0.3", :type=>"runtime"},
        {:name=>"base64", :requirement=>"1.0.1", :type=>"runtime"},
        {:name=>"binary-heap", :requirement=>"1.0.1", :type=>"runtime"},
        {:name=>"tracker", :requirement=>"1.0.3", :type=>"runtime"},
        {:name=>"underscore", :requirement=>"1.0.1", :type=>"runtime"}
      ]
    })
  end
end

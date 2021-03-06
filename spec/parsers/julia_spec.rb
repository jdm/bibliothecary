require 'spec_helper'

describe Bibliothecary::Parsers::Julia do
  it 'has a platform name' do
    expect(Bibliothecary::Parsers::Julia::platform_name).to eq('julia')
  end

  it 'parses dependencies from REQUIRE' do
    expect(Bibliothecary::Parsers::Julia.analyse_file('REQUIRE', fixture_path('REQUIRE'))).to eq({
      :platform=>"julia",
      :path=>"spec/fixtures/REQUIRE",
      :dependencies=>[
        {:name=>"julia", :requirement=>"0.3", :type=>"runtime"},
        {:name=>"Codecs", :requirement=>"*", :type=>"runtime"},
        {:name=>"Colors", :requirement=>"0.3.4", :type=>"runtime"},
        {:name=>"Compat", :requirement=>"*", :type=>"runtime"},
        {:name=>"Compose", :requirement=>"0.3.11", :type=>"runtime"},
        {:name=>"Contour", :requirement=>"*", :type=>"runtime"},
        {:name=>"DataFrames", :requirement=>"0.4.2", :type=>"runtime"},
        {:name=>"DataStructures", :requirement=>"*", :type=>"runtime"},
        {:name=>"Dates", :requirement=>"*", :type=>"runtime"},
        {:name=>"Distributions", :requirement=>"*", :type=>"runtime"},
        {:name=>"Hexagons", :requirement=>"*", :type=>"runtime"},
        {:name=>"Iterators", :requirement=>"0.1.5", :type=>"runtime"},
        {:name=>"JSON", :requirement=>"*", :type=>"runtime"},
        {:name=>"KernelDensity", :requirement=>"*", :type=>"runtime"},
        {:name=>"Loess", :requirement=>"*", :type=>"runtime"},
        {:name=>"Showoff", :requirement=>"0.0.3", :type=>"runtime"},
        {:name=>"StatsBase", :requirement=>"*", :type=>"runtime"}
      ]
    })
  end
end

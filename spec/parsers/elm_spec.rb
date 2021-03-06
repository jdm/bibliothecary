require 'spec_helper'

describe Bibliothecary::Parsers::Elm do
  it 'has a platform name' do
    expect(Bibliothecary::Parsers::Elm::platform_name).to eq('elm')
  end

  it 'parses dependencies from elm-package.json' do
    expect(Bibliothecary::Parsers::Elm.analyse_file('elm-package.json', fixture_path('elm-package.json'))).to eq({
      :platform=>"elm",
      :path=>"spec/fixtures/elm-package.json",
      :dependencies=>[
        {:name=>"evancz/elm-markdown",
         :requirement=>"1.1.0 <= v < 2.0.0",
         :type=>"runtime"},
        {:name=>"evancz/elm-html",
         :requirement=>"1.0.0 <= v < 2.0.0",
         :type=>"runtime"},
        {:name=>"evancz/local-channel",
         :requirement=>"1.0.0 <= v < 2.0.0",
         :type=>"runtime"},
        {:name=>"elm-lang/core",
         :requirement=>"1.0.0 <= v < 2.0.0",
         :type=>"runtime"}
      ]
    })
  end

  it 'parses dependencies from elm_dependencies.json' do
    expect(Bibliothecary::Parsers::Elm.analyse_file('elm_dependencies.json', fixture_path('elm_dependencies.json'))).to eq({
      :platform=>"elm",
      :path=>"spec/fixtures/elm_dependencies.json",
      :dependencies=>[
        {:name=>"johnpmayer/elm-webgl", :requirement=>"0.1.1", :type=>"runtime"},
        {:name=>"johnpmayer/elm-linear-algebra",
         :requirement=>"1.0.1",
         :type=>"runtime"}
      ]
    })
  end

  it 'parses dependencies from elm-stuff/exact-dependencies.json' do
    expect(Bibliothecary::Parsers::Elm.analyse_file('elm-stuff/exact-dependencies.json', fixture_path('exact-dependencies.json'))).to eq({
      :platform=>"elm",
      :path=>"spec/fixtures/exact-dependencies.json",
      :dependencies=>[
        {:name=>"jvoigtlaender/elm-drag-and-drop",
         :requirement=>"1.0.1",
         :type=>"runtime"},
        {:name=>"evancz/elm-html", :requirement=>"2.0.0", :type=>"runtime"},
        {:name=>"elm-lang/core", :requirement=>"1.1.1", :type=>"runtime"},
        {:name=>"evancz/automaton", :requirement=>"1.0.0", :type=>"runtime"},
        {:name=>"evancz/virtual-dom", :requirement=>"1.2.2", :type=>"runtime"}
      ]
    })
  end
end

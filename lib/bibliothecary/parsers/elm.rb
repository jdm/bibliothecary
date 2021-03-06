require 'json'

module Bibliothecary
  module Parsers
    class Elm
      include Bibliothecary::Analyser

      def self.parse(filename, path)
        if filename.match(/^elm-package\.json$|^elm_dependencies\.json$/)
          file_contents = File.open(path).read
          json = JSON.parse file_contents
          parse_json_manifest(json)
        elsif filename.match(/^elm-stuff\/exact-dependencies\.json$/)
          file_contents = File.open(path).read
          json = JSON.parse file_contents
          parse_json_lock(json)
        else
          []
        end
      end

      def self.analyse(folder_path, file_list)
        [analyse_json(folder_path, file_list),
        analyse_json_lock(folder_path, file_list)]
      end

      def self.analyse_json(folder_path, file_list)
        path = file_list.find{|path| path.gsub(folder_path, '').gsub(/^\//, '').match(/^elm-package\.json$|^elm_dependencies\.json$/) }
        return unless path

        manifest = JSON.parse File.open(path).read

        {
          platform: PLATFORM_NAME,
          path: path,
          dependencies: parse_json_manifest(manifest)
        }
      rescue
        []
      end

      def self.analyse_json_lock(folder_path, file_list)
        path = file_list.find{|path| path.gsub(folder_path, '').gsub(/^\//, '').match(/^elm-stuff\/exact-dependencies\.json$/) }
        return unless path

        manifest = JSON.parse File.open(path).read

        {
          platform: PLATFORM_NAME,
          path: path,
          dependencies: parse_json_lock(manifest)
        }
      rescue
        []
      end

      def self.parse_json_manifest(manifest)
        map_dependencies(manifest, 'dependencies', 'runtime')
      end

      def self.parse_json_lock(manifest)
        manifest.map do |name, requirement|
          {
            name: name,
            requirement: requirement,
            type: 'runtime'
          }
        end
      end

      def self.map_dependencies(hash, key, type)
        hash.fetch(key,[]).map do |name, requirement|
          {
            name: name,
            requirement: requirement,
            type: type
          }
        end
      end
    end
  end
end

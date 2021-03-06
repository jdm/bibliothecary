require 'gemnasium/parser'
require 'yaml'

module Bibliothecary
  module Parsers
    class CocoaPods
      include Bibliothecary::Analyser

      NAME_VERSION = '(?! )(.*?)(?: \(([^-]*)(?:-(.*))?\))?'.freeze
      NAME_VERSION_4 = /^ {4}#{NAME_VERSION}$/

      def self.parse(filename, path)
        if filename.match(/^Podfile$/)
          file_contents = File.open(path).read
          manifest = Gemnasium::Parser.send(:podfile, file_contents)
          parse_manifest(manifest)
        elsif filename.match(/^[A-Za-z0-9_-]+\.podspec$/)
          file_contents = File.open(path).read
          manifest = Gemnasium::Parser.send(:podspec, file_contents)
          parse_manifest(manifest)
        elsif filename.match(/^Podfile\.lock$/)
          file_contents = File.open(path).read
          manifest = YAML.load file_contents
          parse_podfile_lock(manifest)
        elsif filename.match(/^[A-Za-z0-9_-]+\.podspec.json$/)
          file_contents = File.open(path).read
          json = JSON.parse(file_contents)
          parse_json_manifest(json)
        else
          []
        end
      end

      def self.parse_podfile_lock(manifest)
        manifest['PODS'].map do |row|
          pod = row.is_a?(String) ? row : row.keys.first
          match = pod.match(/(.+?)\s\((.+?)\)/i)
          {
            name: match[1].split('/').first,
            requirement: match[2],
            type: 'runtime'
          }
        end.compact
      end

      def self.parse_manifest(manifest)
        manifest.dependencies.inject([]) do |deps, dep|
          deps.push({
            name: dep.name,
            requirement: dep.requirement.to_s,
            type: dep.type
          })
        end.uniq
      end

      def self.parse_json_manifest(manifest)
        manifest['dependencies'].inject([]) do |deps, dep|
          deps.push({
            name: dep[0],
            requirement: dep[1],
            type: 'runtime'
          })
        end.uniq
      end
    end
  end
end

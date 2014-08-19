require 'xcresources/helper/file_helper'
require 'xcresources/model/section'

module XCResources

  # An +Analyzer+ scans the project for references,
  # which should be included in the output file.
  #
  class Analyzer
    include XCResources::FileHelper

    # @return [Xcodeproj::Project]
    #         the Xcodeproj to analyze
    attr_reader :project

    # @return [Array<Section>]
    #         the built sections
    attr_reader :sections

    # @return [Array<String>]
    #         the exclude file patterns
    attr_accessor :exclude_file_patterns

    # @return [Logger]
    #         the logger
    attr_accessor :logger

    delegate :inform, :log, :success, :warn, :fail, to: :logger

    # Initialize a new analyzer
    #
    # @param [Xcodeproj::Project] project
    #        see +project+.
    #
    # @param [Hash] options
    #        see subclasses.
    #
    def initialize(project=nil, options={})
      @project = project
      @sections = []
      @exclude_file_patterns = []
    end

    # Analyze the project
    #
    # @return [Array<Section>]
    #         the built sections
    #
    def analyze
      # Empty stub implementation
    end

    # Apply the configured exclude file patterns to a list of files
    #
    # @param [Array<Pathname>] file_paths
    #        the list of files to filter
    #
    # @param [Array<Pathname>]
    #        the filtered list of files
    #
    def filter_exclusions file_paths
      file_paths.reject do |path|
        exclude_file_patterns.any? { |pattern| File.fnmatch("#{pattern}", path) || File.fnmatch("**/#{pattern}", path) }
      end
    end

    # Discover all references to files with a specific extension in project,
    # which belong to a build phase of an application target.
    #
    # @param  [String] extname
    #         the extname, which contains a leading dot
    #         e.g.: '.bundle', '.strings'
    #
    # @return [Array<PBXFileReference>]
    #
    def find_file_refs_by_extname(extname)
      project.files.select do |file_ref|
        File.extname(file_ref.path) == extname \
        && is_file_ref_included_in_any_build_phase?(file_ref)
      end
    end

    # Checks if a file ref is included in any resources build phase of any
    # of the application targets of the #project.
    #
    # @param  [PBXFileReference] file_ref
    #         the file to search for
    #
    # @return [Bool]
    #
    def is_file_ref_included_in_any_build_phase?(file_ref)
      puts "look for: #{file_ref.inspect}"
      application_targets.any? do |target|
        target.build_phases.any? do |phase|
          phase.files.any? do |build_file|
            build_file.file_ref == file_ref
          end
        end
      end
    end

    # Find all application targets in the project
    #
    # @return [Array<PBXNativeTarget>]
    #
    def application_targets
      project.targets.select do |target|
        target.is_a?(Xcodeproj::Project::Object::PBXNativeTarget) \
        && target.product_type == Xcodeproj::Constants::PRODUCT_TYPE_UTI[:application]
      end
    end

  end
end

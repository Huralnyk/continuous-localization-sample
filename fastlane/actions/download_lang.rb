require 'net/http'

module Fastlane
  module Actions
    module SharedValues
      DOWNLOAD_LANG = :DOWNLOAD_LANG
    end

    class DownloadLangAction < Action
      def self.run(params)
      	require 'net/http'
		require 'json'

		# Make POST request to fetch language download link
      	uri = URI("https://api.poeditor.com/v2/projects/export")
      	res = Net::HTTP.post_form(uri, api_token: params[:api_token], id: params[:project_id], language: params[:lang], type: "apple_strings")
      	
      	# Parse download link from response
      	json = JSON.parse(res.body)
      	translation_uri = URI(json["result"]["url"])

      	# Download transtlation to a file
      	transtalion_res = Net::HTTP.get(translation_uri)
      	file = File.new("#{params[:strings_path]}/#{params[:lang]}.lproj/Localizable.strings", "w")
      	file.puts(transtalion_res)
      	file.close

      	# Print a pretty message about action success
      	flag = params[:lang].upcase.tr('A-Z', "\u{1F1E6}-\u{1F1FF}")
        UI.success "Successfuly imported #{flag}  translation"

        Actions.lane_context[SharedValues::DOWNLOAD_LANG] = transtalion_res
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Download a Localizable.strings file from POEditor and puts it to Xcode project"
      end

      def self.details
      	[
      	  "First setup Fastlane environemnt variables POEDITOR_API_TOKEN, POEDITOR_PROJECT_ID, XCODE_STRING_RESOURCES_PATH.",
      	  "Then specify a language code for a Localizable.strings you wish to import as `lang` parameter to action."
      	].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: "POEDITOR_API_TOKEN", # The name of the environment variable
                                       description: "API Token for POEditor", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No API token for POEditor given, pass using `api_token: 'token'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :project_id,
                                       env_name: "POEDITOR_PROJECT_ID", # The name of the environment variable
                                       description: "POEditor project id", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No POEditor project id given, pass using `project_id: 'id'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :strings_path,
                                       env_name: "XCODE_STRING_RESOURCES_PATH", # The name of the environment variable
                                       description: "Path to folder with string resources, e.g Base.lproj", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No path to folder with Base.lproj provided, please set XCODE_STRING_RESOURCES_PATH in .env file") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :lang,
                                       description: "Language code", # a short description of this parameter
                                       verify_block: proc do |value|
                                          UI.user_error!("No language code given, pass using `lang: 'en'`") unless (value and not value.empty?)
                                          # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       end)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['DOWNLOAD_LANG', 'The content of Localizable.strings file you just downloaded']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        ["Huralnyk"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end

require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

namespace :gmail do 
  desc "Run gmail API" 
	task run: :environment do
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    APPLICATION_NAME = 'gsquares'
    # CLIENT_SECRETS_PATH = 'client_secret.json'
    CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                                "gsquares.yaml")
    SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

    def authorize
      FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

      client_id = Google::Auth::ClientId.new(ENV['gmail_id'], ENV['gmail_secret'])
      token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(
        client_id, SCOPE, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)
      if credentials.nil?
        url = authorizer.get_authorization_url(
          base_url: OOB_URI)
        puts "Open the following URL in the browser and enter the " +
            "resulting code after authorization"
        puts url
        code = ENV['gmail_code']
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI)
      end
      credentials
    end

    service = Google::Apis::GmailV1::GmailService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    prev_day = 1.day.ago
    prev_day = "#{prev_day.year}/#{prev_day.month}/#{prev_day.day}"

    user_id = 'me'
    Student.where(daily_email: true).each do |student|
      query= "from:#{student.email} after:#{prev_day}"
      result = service.list_user_messages(user_id, q: query)
      emailed_today = false 

      if result.messages.length > 0
        result.messages.each do |message|
          message_time = service.get_user_message('me', "15dbd76e73f779d1").payload.headers[18].value.to_datetime
          prev_time = Time.zone.now - 16.hours
          if message_time > prev_time 
            emailed_today = true
            break
          end
        end
      end

      unless emailed_today 
        puts "Notify that this student didn't email today"
      end

    end
  end
end

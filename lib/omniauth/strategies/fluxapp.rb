require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Fluxapp < OmniAuth::Strategies::OAuth2
      auth_host = 'http://192.168.1.19:3000'
      option :name, :fluxapp
      option :client_options, {
        :site => "#{auth_host}",
        :authorize_url => "#{auth_host}/oauth/authorize",
        # :authorize_url => "/oauth/authorize",       
        :token_url => "#{auth_host}/oauth/access_token"
      }

      def request_phase
        super
      end
      
      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'nickname' => raw_info['nickname'],
          'email' => raw_info["email"],
          'name' => raw_info['name'],
          'image' => raw_info['image_url'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        # access_token.options[:mode] = :query
        # @raw_info ||= access_token.get('user').parsed
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end

      def email
         (email_access_allowed?) ? primary_email : raw_info['email']
      end

      def primary_email
        primary = emails.find{|i| i['primary'] }
        primary && primary['email'] || emails.first && emails.first['email']
      end

      # The new /user/emails API - http://developer.github.com/v3/users/emails/#future-response
      def emails
        return [] unless email_access_allowed?
        access_token.options[:mode] = :query
        @emails ||= access_token.get('user/emails', :headers => { 'Accept' => 'application/vnd.github.v3' }).parsed
      end

      def email_access_allowed?
        options['scope'] =~ /user/
      end

    end
  end
end

# OmniAuth.config.add_camelization 'github', 'GitHub'

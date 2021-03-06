###########################################################################
# AWS Elastic Beanstalk Command Line Client
# Copyright 2011 Amazon.com, Inc. or its affiliates. All Rights Reserved.
# 
# Licensed under the Apache License, Version 2.0 (the “License”). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#    http://aws.amazon.com/apache2.0/
#
# or in the “license” file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#
require 'aws/client/commandline'
require 'json'

module AWS
  module ElasticBeanstalk
    class OptionSettingsCLI < AWS::Client::CommandLine
      def parse_options_file(prefix, options_file)
        return unless File.exists?(options_file)
        
        key_counter = 0
        
        JSON.parse(File.open(options_file).read).each do |option_setting|
          key_counter += 1
          
          option_setting.each do |key, value|
            service_param("#{prefix}.member.#{key_counter}.#{key}", value)
          end
        end
      end
    end
  end
end

Vagrant.configure("2") do |config|

  config.vm.provider :aws do |aws|
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.region = ENV['AWS_DEFAULT_REGION']

    # Simple region config
    aws.region_config ENV['AWS_DEFAULT_REGION'], :ami => ENV['AWS_DEFAULT_AMI']

  end
end

$VAGRANT_CONFIG_VERSON = 2

Vagrant.require_plugin "vagrant-aws"
Vagrant.require_plugin "vagrant-winrm-syncedfolders"

Vagrant.configure($VAGRANT_CONFIG_VERSION) do |config|
  config.vm.box = "dummy"
  config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/blob/master/dummy.box?raw=true"
  config.vm.communicator = "winrm"
  config.vm.guest = :windows

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    aws.keypair_name = ENV["AWS_KEYPAIR_NAME"]

    aws.ami = "ami-fa05b392"
    aws.tags = {
      'Name' => ENV["ASSET_NAME"],
      'net.matrix.orgunit' => "Matrix NOC",
      'net.matrix.organization' => "Private Ops",
      'net.matrix.commonname' => "cloud",
      'net.matrix.locality' => "Dallas",
      'net.matrix.state' => "Texas",
      'net.matrix.country' => "USA",
      'net.matrix.environment' => "production",
      'net.matrix.application' => "infrastructure",
      'net.matrix.role' => "application services",
      'net.matrix.owner' => "FC13F74B@matrix.net",
      'net.matrix.customer' => "PVT-01",
      'net.matrix.costcenter' => "INT-01"
    }
    
    aws.instance_type = "t2.micro"
    aws.region = ENV["AWS_DEFAULT_REGION"]
    #aws.subnet_id = ENV["AWS_SUBNET"]
    #aws.security_groups = ENV["AWS_SECURITY_GROUPS"]
    override.nfs.functional = false # workaround for upstream issue #340
    override.winrm.username = "Administrator"
    override.winrm.password = Base64.decode(ENV["WIN32_ACCESS_TOKEN"])
    override.vm.communicator = :winrm
    config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
    config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
    config.vm.provision :shell, inline: <<-EOL
      # set administrator password
      net user Administrator ${Base64.decode(ENV["WIN32_ACCESS_TOKEN"])}
      wmic useraccount where "name='Administrator'" set PasswordExpires=FALSE
      
      # configure WinRM
      winrm quickconfig -q  
      winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="0"}'  
      winrm set winrm/config '@{MaxTimeoutms="7200000"}'  
      winrm set winrm/config/service '@{AllowUnencrypted="true"}'  
      winrm set winrm/config/service/auth '@{Basic="true"}'
      
      netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
      
      net stop winrm  
      sc config winrm start=auto  
      net start winrm
      
      # turn off PowerShell execution policy restrictions
      Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine
      
      
    EOL

  end
end

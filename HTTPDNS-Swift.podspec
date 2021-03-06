Pod::Spec.new do |s|

  s.name         = "HTTPDNS-Swift"
  s.version      = "0.7.0"
  s.summary      = "Use HTTP to resolve domain (Swift)"

  s.description  = <<-DESC
                   HttpDNS 库 Swift 实现（使用DNSPod、AliYunDNS）
                   DESC

  s.homepage     = "https://github.com/yourtion/HTTPDNS-Swift"
  s.license      = "MIT"
  s.author       = { "Yourtion" => "yourtion@gmail.com" }
  s.source       = { :git => "https://github.com/yourtion/HTTPDNS-Swift.git", :tag => s.version }
  s.source_files  = "HTTPDNS/*.swift"
  
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  
  s.frameworks  = "Foundation"
  s.requires_arc = true

end

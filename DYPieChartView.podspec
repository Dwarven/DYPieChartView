Pod::Spec.new do |s|

  s.name                  = 'DYPieChartView'
  s.version               = '0.0.4'
  s.summary               = 'Animated Pie Chart using Custom CALayer.'
  s.homepage              = 'https://github.com/Dwarven/DYPieChartView'
  s.ios.deployment_target = '7.0'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'Dwarven' => 'prison.yang@gmail.com' }
  s.social_media_url      = "https://twitter.com/DwarvenYang"
  s.source                = { :git => 'https://github.com/Dwarven/DYPieChartView.git', :tag => s.version }
  s.source_files          = 'Class/*.{h,m}'

end

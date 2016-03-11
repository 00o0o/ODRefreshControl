Pod::Spec.new do |s|
  s.name     = 'ODRefreshControl'
  s.version  = '1.2'
  s.license  = 'MIT'
  s.summary  = "A pull down to refresh control like the one in Apple's iOS6 Mail App."
  s.homepage = 'https://github.com/00o0o/ODRefreshControl'
  s.author   = { 'Clover' => 'mr.coke@163.com' }
  s.source   = { :git => 'https://github.com/00o0o/ODRefreshControl.git', :tag => '1.3' }

  s.description = 'ODRefreshControl is a "pull down to refresh" control for UIScrollView,' \
                  'like the one Apple introduced in iOS6, but available to anyone from iOS4 and up.'
  s.platform    = :ios

  s.source_files = 'ODRefreshControl/ODRefreshControl*.{h,m}'
  #s.clean_path   = 'Demo'
  s.framework    = 'QuartzCore'

  s.requires_arc = true
end

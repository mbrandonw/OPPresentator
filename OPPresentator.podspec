Pod::Spec.new do |spec|
  spec.name         = 'OPPresentator'
  spec.version      = '0.1.0'
  spec.license      = { type: 'BSD' }
  spec.homepage     = 'https://github.com/mbrandonw/OPPresentator'
  spec.authors      = { 'Brandon Williams' => 'mbw234@gmail.com' }
  spec.summary      = ''
  spec.source       = { :git => 'https://github.com/mbrandonw/OPPresentator.git' }
  spec.source_files = '*.{h,m}'
  spec.requires_arc = true
end

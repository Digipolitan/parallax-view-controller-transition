Pod::Spec.new do |s|
s.name = "DGParallaxViewControllerTransition"
s.version = "1.1.0"
s.summary = "Parallax interactive transition during UIViewController presentation"
s.homepage = "https://github.com/Digipolitan/parallax-view-controller-transition"
s.authors = "Digipolitan"
s.source = { :git => "https://github.com/Digipolitan/parallax-view-controller-transition.git", :tag => "v#{s.version}" }
s.license = { :type => "BSD", :file => "LICENSE" }
s.source_files = 'Sources/**/*.{swift,h}'
s.ios.deployment_target = '8.0'
s.tvos.deployment_target = '9.0'
s.requires_arc = true
end

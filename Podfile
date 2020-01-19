# Disable sending stats
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, :deployment_target => '10.0'
#inhibit_all_warnings!
use_frameworks!

def injector
  pod 'Swinject'
  #pod 'SwinjectStoryboard'
end

def react
  pod 'RxSwift'
  pod 'RxSwiftExt'
end

def test_pods
  pod 'RxTest'
  pod 'RxBlocking'
  pod 'SwiftyMocky', :inhibit_warnings => true
end

target 'WeatherApp' do

  pod 'RxDataSources'
  
  injector
  react

  target 'WeatherAppTests' do
    inherit! :search_paths
    test_pods
  end
end
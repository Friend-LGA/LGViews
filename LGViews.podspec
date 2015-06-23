Pod::Spec.new do |s|

    s.name = 'LGViews'
    s.version = '1.0.0'
    s.platform = :ios, '6.0'
    s.license = 'MIT'
    s.homepage = 'https://github.com/Friend-LGA/LGViews'
    s.author = { 'Grigory Lutkov' => 'Friend.LGA@gmail.com' }
    s.source = { :git => 'https://github.com/Friend-LGA/LGViews.git', :tag => s.version }
    s.summary = 'Classes extends abilities of UILabel, UIButton, UITextField and UITextView'

    s.requires_arc = true

    s.source_files = 'LGViews/*.{h,m}'

    s.subspec 'LGButton' do |ss|
        ss.source_files = 'LGViews/LGButton/*.{h,m}'
    end

    s.subspec 'LGLabel' do |ss|
        ss.source_files = 'LGViews/LGLabel/*.{h,m}'
    end

    s.subspec 'LGTextField' do |ss|
        ss.source_files = 'LGViews/LGTextField/*.{h,m}'
    end

    s.subspec 'LGTextView' do |ss|
        ss.source_files = 'LGViews/LGTextView/*.{h,m}'
    end

end

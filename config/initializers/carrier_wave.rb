if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['ap-northeast-1'],
      :aws_access_key_id     => ENV['AKIAWL3HJNRWINDSDZH6'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['taishibucket']
  end
end
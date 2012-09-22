include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence(:user_email) { |n| "user#{n}@example.com" }
  sequence(:user_name) { |n| "user#{n}" }
  sequence(:other_email) { |n| "other#{n}@email.com" }
  sequence(:other_name) { |n| "other#{n}" }
  sequence(:password) { |n| "password#{n}" }

  factory :attachment do
    attachment    { fixture_file_upload('spec/samples/img.png', 'image/png') }
    content_type  'image/png'
    file_size     1000

    factory :pdfpng do
      attachment  { fixture_file_upload('spec/samples/pdf.png', 'image/png') }
    end

    factory :txtpng do
      attachment  { fixture_file_upload('spec/samples/txt.png', 'image/png') }
    end

    factory :zippng do
      attachment  { fixture_file_upload('spec/samples/zip.png', 'image/png') }
    end
  end

  factory :category do
    name 'Funny'
    description 'Pictures of cats'

    trait :beer do
      name 'Beer'
      description 'Nectar of the Gods!'
    end
  end

  factory :messageboard do
    sequence(:name) { |n| "messageboard#{n}" }
    sequence(:title) { |n| "Messageboard #{n}" }
    description 'This is a description of the messageboard'
    theme 'default'
    security 'public'
    posting_permission  'anonymous'
  end

  factory :post do
    sequence(:content) { |n| "A post about the number #{n}" }
    user
    topic
    messageboard
    ip '127.0.0.1'
    filter 'bbcode'
  end

  factory :preference do
    notify_on_mention false
    notify_on_message false
  end

  factory :private_topic do
    title 'New private topic started here'
    user
    association :last_user, factory: :user
    messageboard
  end

  factory :private_user do
    private_topic_id 1
    user_id 1
  end

  factory :role do
    level 'admin'
    messageboard

    factory :role_admin do
      level 'admin'
    end

    factory :role_superadmin do
      level 'superadmin'
    end

    factory :role_moderator do
      level 'moderator'
    end

    factory :role_member do
      level 'member'
    end
  end

  factory :site do
    user
    sequence(:subdomain) { |n| "site#{n}" }
    cached_domain        'website.com'
    cname_alias          'website.com'
    permission           'public'
    title                'Default website'
    description          'default website description'
    home                 'messageboards'
    email_from           'Site <email@email.com>'
    email_subject_prefix '[Email] '
    default_site         'f'
  end

  factory :topic do
    user
    messageboard
    title 'New topic started here'
    association :last_user, :factory => :user

    trait :with_5_posts do
      posts { create_list(:post, 5) }
    end
  end

  factory :user do
    email { FactoryGirl.generate(:user_email) }
    name  { FactoryGirl.generate(:user_name) }
    current_sign_in_at 10.minutes.ago
    last_sign_in_at    10.minutes.ago
    current_sign_in_ip '192.168.1.1'
    last_sign_in_ip    '192.168.1.1'
    superadmin         'f'
    time_zone          'Eastern Time (US & Canada)'
    password

    factory :email_confirmed_user do
      email              { FactoryGirl.generate(:user_email) }
      name               { FactoryGirl.generate(:user_name) }
    end

    factory :last_user do
      email              { FactoryGirl.generate(:other_email) }
      name               { FactoryGirl.generate(:other_name) }
    end
  end

  factory :user_topic_read do
    user_id 1
    topic_id 1
    post_id 1
    page 1
  end
end

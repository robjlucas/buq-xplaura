module Features
  module NoticeHelpers
    extend RSpec::Matchers::DSL

    matcher :show_alert do |expected|
      match do |actual|
        expect(actual).to have_css(".flash-message", text: expected)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Features::NoticeHelpers, type: :feature
end

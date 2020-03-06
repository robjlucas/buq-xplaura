module Features
  module NoticeHelpers
    extend RSpec::Matchers::DSL

    matcher :show_notice do |expected|
      match do |actual|
        expect(actual).to have_css(".flash-message.success", text: expected)
      end
    end

    matcher :show_alert do |expected|
      match do |actual|
        expect(actual).to have_css(".flash-message.alert", text: expected)
      end
    end

    matcher :show_error do |expected|
      match do |actual|
        expect(actual).to have_css(".flash-message.error", text: expected)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Features::NoticeHelpers, type: :feature
end

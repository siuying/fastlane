module Danger
  class Dangerfile
    module DSL
      class Plugin
        attr_accessor :current_markdown

        def pr_body # needed for the action
          ""
        end

        def markdown(str)
          @current_markdown ||= ""
          @current_markdown += "#{str}\n"
        end
      end
    end
  end
end

describe Fastlane do
  describe "DeviceGrid" do
    it "works" do
      require 'fastlane/actions/device_grid/device_grid'
      public_key = "1461233806"
      public_key_path = "fastlane/appetize_public_key.txt"
      File.write(public_key_path, public_key)
      dg = Danger::Dangerfile::DSL::DeviceGrid.new
      dg.run(languages: ['en', 'de'], devices: ['iphone4s'])

      correct = File.read("spec/fixtures/device_grid_results.html")
      expect(dg.current_markdown).to eq(correct)
      File.delete(public_key_path)
      ENV.delete("FASTLANE_DISABLE_COLORS")
    end
  end
end

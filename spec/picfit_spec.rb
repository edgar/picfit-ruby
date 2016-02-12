require 'spec_helper'

describe Picfit do
  it 'has a version number' do
    expect(Picfit::VERSION).not_to be nil
  end

  describe ".base_url" do
    it "should return the default base url" do
      expect(Picfit.base_url).to eq Picfit::Configuration::DEFAULT_BASE_URL
    end
  end

  describe ".base_url=" do
    it "should set the base_url" do
      Picfit.base_url = "http://foo.com"
      expect(Picfit.base_url).to eq "http://foo.com"
    end
  end
end

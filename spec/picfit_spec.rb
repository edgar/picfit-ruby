require 'spec_helper'

describe Picfit do
  it 'has a version number' do
    expect(Picfit::VERSION).not_to be nil
  end

  describe "when delegating to a client" do
    #
    # Check the client_spec for more methods
    #

    let(:options) {
      {
        width: 100,
        height: 100,
        path: "path/to/file",
        operation: :resize,
        query_string: true
      }
    }

    it "should return the proper image path" do
      # I don't like this too much, b/c the result depends on PICFIT_PARAMS_MAP order,
      # but the intention is more clear
      expect(Picfit.image_path(options)).to eq("display?path=path%2Fto%2Ffile&op=resize&w=100&h=100")
    end
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

  describe ".method" do
    it "should return the default method" do
      expect(Picfit.method).to eq Picfit::Configuration::DEFAULT_METHOD
    end
  end

  describe ".method=" do
    it "should set the method" do
      Picfit.method = :get
      expect(Picfit.method).to eq :get
    end
  end

  describe ".secret_key" do
    it "should return the default secret_key" do
      expect(Picfit.secret_key).to eq Picfit::Configuration::DEFAULT_SECRET_KEY
    end
  end

  describe ".secret_key=" do
    it "should set the secret_key" do
      Picfit.secret_key = "foo"
      expect(Picfit.secret_key).to eq "foo"
    end
  end
end

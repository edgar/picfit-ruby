require 'spec_helper'

describe Picfit::Client do
  let(:client) { Picfit::Client.new }

  describe ".sign_string" do
    #
    # Based on Picfit's README signature example
    #
    it "should return the proper signature" do
      expect(client.sign_string("abcdef", "w=100&h=100&op=resize")).to eq("6f7a667559990dee9c30fb459b88c23776fad25e")
    end
  end

  describe ".image_path" do
    context "when using default method" do

      let(:options) {
        {
          width: 100,
          height: 100,
          path: "path/to/file",
          operation: :resize,
          secret_key: 'abcdef'
        }
      }
      it "should return the proper image path" do
        uri_string = client.image_path(options)

        # I don't like this too much, b/c the result depends on PICFIT_PARAMS_MAP order,
        # but the intention is more clear
        expect(uri_string).to eq("display?path=path%2Fto%2Ffile&op=resize&w=100&h=100&sig=f45506bf02ca3ba84eb34a2a066af7aa315a11c2")

        # Lets check using URI
        uri = URI.parse(uri_string)
        # check the path
        expect(uri.path).to eq(client.method.to_s)
        # check the query string
        params = CGI.parse(uri.query) # each key value is an array
        expect(params['w']).to eq ["100"]
        expect(params['w']).to eq ["100"]
        expect(params['path']).to eq ["path/to/file"]
        expect(params['op']).to eq ["resize"]
        expect(params['sig']).to eq ["f45506bf02ca3ba84eb34a2a066af7aa315a11c2"]
      end
    end

    context "when supplying another method" do
      let(:options) {
        {
          method: :get,
          width: 100,
          height: 100,
          path: "path/to/file",
          operation: :resize
        }
      }
      it "should return the proper image path" do
        uri_string = client.image_path(options)

        # I don't like this too much, b/c the result depends on PICFIT_PARAMS_MAP order,
        # but the intention is more clear
        expect(uri_string).to eq("get?path=path%2Fto%2Ffile&op=resize&w=100&h=100")

        # Lets check using URI
        uri = URI.parse(uri_string)
        # check the path
        expect(uri.path).to eq('get')
        # check the query string
        params = CGI.parse(uri.query) # each key value is an array
        expect(params['w']).to eq ["100"]
        expect(params['w']).to eq ["100"]
        expect(params['path']).to eq ["path/to/file"]
        expect(params['op']).to eq ["resize"]
      end
    end
  end

  describe ".image_url" do
    let(:client) { Picfit::Client.new(base_url: 'http://foo.com') }

    let(:options) {
      {
        width: 100,
        height: 100,
        path: "path/to/file",
        operation: :resize
      }
    }

    it "should return the proper image url" do
      uri_string = client.image_url(options)

      # I don't like this too much, b/c the result depends on PICFIT_PARAMS_MAP order,
      # but the intention is more clear
      expect(uri_string).to eq("http://foo.com/display?path=path%2Fto%2Ffile&op=resize&w=100&h=100")
    end

    context "when supplying custom base_url" do
      let(:options) {
        {
          base_url: 'http://bar.com',
          width: 100,
          height: 100,
          path: "path/to/file",
          operation: :resize
        }
      }

      it "should return the proper url using the custom base_url" do
        uri_string = client.image_url(options)

        # I don't like this too much, b/c the result depends on PICFIT_PARAMS_MAP order,
        # but the intention is more clear
        expect(uri_string).to eq("http://bar.com/display?path=path%2Fto%2Ffile&op=resize&w=100&h=100")
      end
    end
  end


end
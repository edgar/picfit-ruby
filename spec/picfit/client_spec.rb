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
          operation: :resize
        }
      }
      it "should return the proper image path" do
        uri_string = client.image_path(options)

        # I don't like this too much, b/c the result depends on PICFIT_PARAMS_MAP order,
        # but the intention is more clear
        expect(uri_string).to eq("display?path=path%2Fto%2Ffile&op=resize&w=100&h=100")

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
      end
    end

    context "when supplying another method" do
    end
  end
end
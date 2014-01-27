require_relative "../helper"

scope do
  test do
    gem = RubyGem.create(name: "registered", status: "ready")

    gems = [
      excluded = Gemfile::EXCLUDED.sample,
      gem.name,
      unregistered = "unregistered"
    ]

    gemfile = gems.inject("") { |res, gem| res << "gem \"#{ gem }\"\n" }

    post "/gemfile", { content: gemfile }, { "HTTP_ACCEPT" => "application/json" }

    json = JSON.parse(last_response.body)

    registered = {
      "id" => gem.id.to_s,
      "name" => gem.name,
      "status" => gem.status,
      "notes" => gem.notes
    }

    assert_equal [registered], json["registered"]
    assert_equal [unregistered], json["unregistered"]
    assert !json["unregistered"].include?(excluded)
  end
end

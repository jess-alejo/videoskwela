# frozen_string_literal: true

require "rails_helper"
require "models/concerns/reviewable_spec"

RSpec.describe User, type: :model do
  it_behaves_like "reviewable"
end

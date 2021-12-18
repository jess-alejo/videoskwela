# frozen_string_literal: true

require "rails_helper"
require "models/concerns/reviewable_spec"

RSpec.describe Course, type: :model do
  it_behaves_like "reviewable"
end
